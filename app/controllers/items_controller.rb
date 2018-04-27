class ItemsController < BaseController
  before_action :set_project
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:index, :show]
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  def index
    @items = set_project.items.all
  end

  def new
    @item = @project.items.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |f|
        f.html { redirect_to [current_account, set_project, @item], notice: "Item is created." }
        f.json { render :show, status: :created, location: @item }
      end
    else
      flash.now[:alert] = "Something is wrong."
      redirect_to account_project_items_path(current_account, set_project, @items)
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |f|
      if @item.update_attributes(item_params)
        f.html { redirect_to [current_account, set_project, @item], notice: "You have updated the item." }
        f.json { render :show, status: :ok, location: @item}
      else
        flash.now[:alert] = "Something's wrong."
        render "edit"
      end
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "You have deleted your item."
    redirect_to account_project_items_path(current_account, set_project, @items)
  end

  private

  def item_params
    params.require(:item).permit(:term, :name, :content, :image, :project_id, :link, :account_id, detail_ids: [], details_attributes: [:id, :name, :description, :value, :_destroy ])
  end

  def set_item
    @item = set_project.items.find_by slug: params[:id]
  end
  helper_method :set_item

  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
    # Project.find_by slug: params[:id]
  end
  helper_method :set_project

end
