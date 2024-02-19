class SongsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :authorize_admin, only: %i[create update destroy]
  before_action :set_song, only: %i[show update destroy]
  helper_method :sort_column, :sort_direction

  # GET /songs
  def index
    if params[:search]
      @songs = Song.where('title ILIKE ?', "%#{params[:search]}%")
    else
      Rails.cache.fetch('songs:all') do
        @songs = Song.order("#{sort_column} #{sort_direction}")
      end
    end
  end

  # GET /songs/1
  def show
    @song.generate_history_links
    @song
  end

  # POST /songs
  def create
    song = Song.new(song_params)

    if song.save
      render json: SongSerializer.render(song, view: :details), status: :created
    else
      render json: song.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/1
  def update
    if @song.update(song_params)
      render json: SongSerializer.render(@song, view: :details)
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # DELETE /songs/1
  def destroy
    @song.destroy
  end

  private

  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : 'times_played'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.permit(:title, :cover, :notes, :lyrics, :tabs, :author_id, :history, :featured_lyric, :guitar_tabs_url)
  end
end
