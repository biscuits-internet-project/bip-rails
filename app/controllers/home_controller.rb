class HomeController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]

  def index
    @shows = Show.includes(:venue, reviews: :user, tracks: %i[annotations song]).merge(Track.setlist).order(date: :desc).limit(10)
    @posts = BlogPost.includes(:user).order("created_at desc").limit(10)
  end
end
