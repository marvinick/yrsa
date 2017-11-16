class DetailsController < BaseController
  before_action :set_detail
  skip_before_action :authorize_owner!, only: [:show]

  def show; end

  private

  def set_detail
    @item = set_project.items.find(params[:item_id])
    @detail = @item.details.find(params[:id])
  end

  def set_project
    project = Project.find(params[:project_id])
  end
  helper_method :set_project
end
