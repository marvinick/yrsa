class ProjectsController < BaseController
  before_action :set_account
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :check_plan_limit, only: [:new, :create]
  skip_before_action :active_subscription_required!, only: [:index]
  skip_before_action :authorize_owner!, only: [:index, :show]

  def new
    @project = current_account.projects.build
  end

  def create
    @project = current_account.projects.new(project_params)
    if @project.save
      flash[:notice] = "You have created a project."
      redirect_to account_path(current_account)
    else
      render "new"
    end
  end

  def show
    
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = "The project is updated."
      redirect_to account_project_path(@account, @project)
    else
      flash.now[:alert] = "Something is misssing."
      render "edit"
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "The project has been removed."
      redirect_to account_path(@account)
    else
      flash.now[:alert] = "Unable to remove the project."
    end
  end

  private

  def check_plan_limit
    if current_account.plan.projects_allowed == current_account.projects.count
      session[:return_to] = request.fullpath
      message = "You have reached your plan's limit."
      message += "You need to upgrade your plan to add more projects."
      flash[:alert] = message
      redirect_to account_choose_plan_path
    end
  end

  def project_params
    params.require(:project).permit(:title, :description, :account_id, user_ids: [])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_project
    @project = current_account.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Project not found."
      redirect_to root_url
  end
end
