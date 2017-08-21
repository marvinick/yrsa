class ItemsController < BaseController
  before_action :set_project

  def index
    @items = @project.items.all
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
