class ItemsController < BaseController
  before_action :set_project
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:index, :show]
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  def index
    @items = @project.items.all

  end

  def new
    @item = @project.items.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |f|
        f.html { redirect_to [current_account, @project, @item], notice: "Item is created." }
        f.json { render :show, status: :created, location: @item }
      end
    else
      flash.now[:alert] = "Something is wrong."
      redirect_to account_project_items_path(current_account, @project, @items)
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] =  "You have updated the item."
      redirect_to account_project_item_path(current_account, @project, @item)
    else
      flash.now[:alert] = "Something's wrong."
      render "edit"
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "You have deleted your item."
    redirect_to account_project_items_path(current_account, @project, @items)
  end

  private

  def item_params
    params.require(:item).permit(:term, :name, :content, :image, :project_id, :link, :account_id, detail_ids: [], details_attributes: [:id, :name, :description, :value, :_destroy ])
  end

  def set_item
    @item = @project.items.find_by slug: params[:id]
  end

  def set_project
    @project = current_account.projects.find(params[:project_id])
  end
end
