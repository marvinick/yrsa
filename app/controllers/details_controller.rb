class DetailsController < BaseController
  before_action :set_detail

  def show
  end

  private

  def set_detail
    project = Project.find(params[:project_id])
    @item = project.items.find(params[:item_id])
    @detail = @item.details.find(params[:id])
  end

  def set_project
    project = Project.find(params[:project_id])
  end
  helper_method :set_project
end
