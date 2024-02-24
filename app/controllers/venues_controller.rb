class VenuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :authorize_admin, only: %i[create update destroy]
  before_action :set_venue, only: %i[show update destroy]

  def index
    @pagy, @venues = pagy(Venue.order(times_played: :desc))

    # @venues = Rails.cache.fetch('venues:all') do
    #   Venue.order(times_played: :desc)
    # end
  end

  # GET /venues/1
  def show
    @venue
    @shows = @venue.shows.includes(:venue, tracks: %i[annotations song]).merge(Track.setlist).sort do |a, b|
      a.date <=> b.date
    end
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      render json: VenueSerializer.render(@venue), status: :created, location: @venue
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      render json: VenueSerializer.render(@venue)
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.permit(:name, :street, :city, :state, :country, :postal_code, :phone, :website)
  end
end
