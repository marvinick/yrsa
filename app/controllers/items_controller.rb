class ItemsController < BaseController
  before_action :set_project

  def index
    @items = current_account.project.items.all
  end

  def new
    @project = current_account.projects.find(params[:project_id])
    @item = @project.items.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "An item is created."
      redirect_to root_path
    else
      flash.now[:alert] = "Something is wrong."
      render "new"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :project_id, :account_id)
  end

  def set_project
    project = Project.find(params[:project_id])
  end
end
