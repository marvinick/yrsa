class DetailsController < BaseController
  before_action :set_project
  before_action :set_detail, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:show]
  respond_to :html, :json

  def index
    @details = @project.details.all.order('created_at DESC')
  end

  def new
    @detail = @project.details.new
  end

  def create
    @detail = @project.details.new(detail_params)
    @detail.save
    respond_to do |f|
      f.html { redirect_to account_project_path(current_account, @project) }
      f.js
    end
  end

  def show; end

  def edit; end

  def update
    if @detail.update(detail_params)
      redirect_to account_project_details_path(current_account, set_project, @details)
      flash[:notice] = "you just updated a detail"
    end
  end

  def destroy
    @detail.destroy
    respond_to do |f|
      f.js
    end
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
  helper_method :set_project
end
