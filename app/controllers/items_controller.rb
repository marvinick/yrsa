class ItemsController < BaseController
  before_action :set_project

  def index
    @items = current_account.project.items.all
  end

  def new
    project = current_account.projects.find(params[:project_id])
    @item = project.items.build
  end

  private

  def set_project
    project = Project.find(params[:project_id])
  end
end
