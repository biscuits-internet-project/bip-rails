class SideProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  # GET /side_projects
  def index
    side_projects = SideProject.all.order(:name)

    render json: SideProjectSerializer.render(side_projects)
  end
end
