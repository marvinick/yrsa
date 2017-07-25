class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    render json: Project.all
  end

  def create
    project = Project.create(project_params)
    project.author = current_user
    render json: project
  end

  def destroy
    respond_with Project.destroy(params[:id])
  end

  def update
    project = Project.find(params["id"])
    project.update_attributes(project_params)
    respond_with project, json: project
  end

  private
  def project_params
    params.require(:project).permit(:title, :description)
  end
end
