class ItemsController < BaseController
  before_action :set_project
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:index, :show]

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
      redirect_to [current_account, set_project]
    else
      flash.now[:alert] = "Something is wrong."
      render "new"
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "You have updated the item."
      redirect_to root_path
    else
      flash.now[:alert] = "Something's wrong."
      render "edit"
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "You have deleted your item."
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :content, :project_id, :account_id, details_attributes: [:name, :description, :value, :_destroy ])
  end

  def set_project
    project = Project.find(params[:project_id])
  end
  helper_method :set_project
end
