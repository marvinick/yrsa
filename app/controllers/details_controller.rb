class DetailsController < BaseController
  before_action :set_project
  before_action :set_detail, except: [:new, :create]
  skip_before_action :authorize_owner!, only: [:show]

  def new
    @project = current_account.projects.find_by slug: params[:project_id]
    @detail = @project.details.build
  end

  def create
    @project = current_account.projects.find_by slug: params[:project_id]
    @detail = @project.details.new(detail_params)
    if @detail.save
      redirect_to account_project_path(current_account, set_project)
    end
  end

  def show; end

  private

  def detail_params
    params.require(:detail).permit(:name, :description)
  end

  def set_detail
    @item = set_project.items.find(params[:item_id])
    @detail = @item.details.find(params[:id])
  end

  def set_project
    project = Project.find_by slug: params[:project_id]
  end
  helper_method :set_project
end
