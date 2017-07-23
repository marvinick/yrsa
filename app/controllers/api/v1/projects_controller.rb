class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    render json: Project.all
  end 
end
