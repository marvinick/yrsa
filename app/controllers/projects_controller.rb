class ProjectsController < BaseController
  before_action :set_account
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :check_plan_limit, only: [:new, :create]
  skip_before_action :active_subscription_required!, only: [:index]

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

  def show
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = "The project is updated."
      redirect_to account_projects_path(@account)
    else
      flash.now[:alert] = "Something is misssing."
      render "edit"
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "The project has been removed."
      redirect_to account_projects_path(@account)
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
    @project = @account.projects.find(params[:id])
  end
end
