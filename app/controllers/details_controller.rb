class DetailsController < BaseController
  before_action :set_project
  before_action :set_detail, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:show]
  respond_to :html, :json

  def index
    @details = set_project.details.all
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
      flash[:notice] = "an attr is updated"
      redirect_to account_project_path(current_account, set_project)
    end
  end

  def destroy
    @detail.destroy
    redirect_to account_project_path(current_account, set_project)
  end

  private

  def detail_params
    params.require(:detail).permit(:name, :description)
  end

  def set_detail
    @detail = set_project.details.find(params[:id])
  end

  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
  end
  helper_method :set_project
end
