class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    render json: Project.all
  end

  def create
    respond_with :api, :v1, Project.create(project_params)
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
