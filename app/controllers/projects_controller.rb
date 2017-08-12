class ProjectsController < ApplicationController
  before_action :set_account
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = @account.projects.build
  end

  def create
    @project = @account.projects.new(project_params)
    if @project.save
      flash[:notice] = "You have created a project."
      redirect_to account_projects_path(@account)
    else
      render "new"
    end
  end

  def show; end

  def edit; end

  def update
    if @account.project.update(project_params)
      flash[:notice] = "The project is updated."
      redirect_to account_project_path(@account, @project)
    else
      flash.now[:alert] = "Something is misssing."
      render "edit"
    end
  end

  def destroy
  end 

  private

  def project_params
    params.require(:project).permit(:title, :description, :account_id)
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_project
    @project = @account.projects.find(params[:id])
  end
end
