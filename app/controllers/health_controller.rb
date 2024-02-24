class HealthController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index clear]

  def index
    render json: { "ping" => "pong" }
  end

  def clear
    ClearCacheJob.perform_later
    render json: { "clear" => "true" }
  end
end
