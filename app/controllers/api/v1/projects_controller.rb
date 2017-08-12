
  # class Api::V1::ProjectsController < Api::V1::BaseController
  #   before_action :authenticate_user!
  #
  #   def index
  #     render json: Project.includes(:author).all
  #   end
  #
  #   def create
  #     project = Project.new(project_params)
  #     project.author = current_user
  #     project.save
  #     respond_with :api, :v1, project
  #   end
  #
  #   def destroy
  #     respond_with Project.destroy(params[:id])
  #   end
  #
  #   def update
  #     project = Project.find(params["id"])
  #     project.update_attributes(project_params)
  #     respond_with project, json: project
  #   end
  #
  #   private
  #   def project_params
  #     params.require(:project).permit(:title, :description, :author_id, :account_id, user_ids: [])
  #   end
  # end
