class DetailsController < BaseController
  before_action :set_project
  before_action :set_detail, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:show]
  respond_to :html, :json

  def index
    @detail = @project.details.new
    @details = @project.details.all.order('created_at DESC')
  end

  def new
    @detail = @project.details.new
  end

  def create
    @detail = @project.details.new(detail_params)
    if @detail.save
      flash[:notice] = "#{@detail.name} has just been added."
      redirect_to account_project_details_path(current_account, @project, @details)
    end
  end

  def show; end

  def edit; end

  def update
    if @detail.update(detail_params)
      flash[:notice] = "you just updated #{@detail.name}"
      redirect_to account_project_details_path(current_account, @project, @details)
    end
  end

  def destroy
    @detail.destroy
    flash[:notice] = "#{@detail.name} has just been deleted."
    redirect_to account_project_details_path(current_account, @project, @details)
  end

  private

  def detail_params
    params.require(:detail).permit(:name, :description)
  end

  def set_detail
    @detail = set_project.details.find(params[:id])
  end

  def set_project
    @project = current_account.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "cannot find that project."
      redirect_to account_project_path(current_account, @project)
  end

end
