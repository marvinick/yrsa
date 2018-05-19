class ProjectsController < BaseController
  before_action :set_account
  before_action :set_project, only: [:show, :edit, :update, :destroy, :unfollow]
  before_action :check_plan_limit, only: [:new, :create]
  skip_before_action :active_subscription_required!, only: [:index]
  skip_before_action :authorize_owner!, only: [:index, :show]
  skip_before_action :verify_authenticity_token, only: [:edit, :update]

  respond_to :html, :json

  def new
    @project = current_account.projects.build
  end

  def create
    @project = current_account.projects.new(project_params)
    user = current_user
    @project.user_id = current_user.id
    current_user.projects << @project
    if @project.save
      flash[:notice] = "You have created a project."
      redirect_to account_project_path(current_account, @project)
    else
      render "form"
    end
  end

  def index
    @projects = current_account.projects.all
    respond_with(@projects)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Project not found."
    redirect_to root_url
  end

  def show
    @detail = set_project.details.build
    @details = set_project.details.all
    @items = set_project.items.all
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
      redirect_to root_url
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
      flash.now[:alert] = message
      redirect_to account_choose_plan_path
    end
  end

  def project_looker
    unless  @project.users.include? current_user.email
      flash[:alert] = "you're not a member"
      redirect_to root_url
    end
  end

  def project_params
    params.require(:project).permit(:title, :id, :description, :account_id, user_ids: [])
  end

  def set_account
    @account = Account.find(params[:account_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Unauthorized access."
      redirect_to root_url
  end

  def set_project
    @project = current_account.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Project not found."
      redirect_to root_url
  end
  helper_method :set_project
end
