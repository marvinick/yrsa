class DetailsController < BaseController
  before_action :set_project
  before_action :set_detail, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:show]

  def new
    @project = current_account.projects.find_by slug: params[:project_id]
    @detail = @project.details.new
  end

  def create
    @project = current_account.projects.find_by slug: params[:project_id]
    @detail = @project.details.new(detail_params)
    if @detail.save
      respond_to do |format|
        format.html { redirect_to account_project_path(current_account, set_project) }
        format.js {}
      end
    end
  end

  def show; end

  def index
    @details = set_project.details.all
  end

  def destroy
    @detail.destroy
    redirect_to account_project_details_path(current_account, set_project, @details)
  end

  private

  def detail_params
    params.require(:detail).permit(:name, :description)
  end

  def set_detail

    @detail = set_project.details.find(params[:id])
  end

  def set_project
    current_account.projects.find_by slug: params[:project_id]
  end
  helper_method :set_project
end
