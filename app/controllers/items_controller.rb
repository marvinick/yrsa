class ItemsController < BaseController
  before_action :set_project
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!, only: [:index, :show]
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  def index
    @items = current_account.project.items.all
  end

  def new
    @project = current_account.projects.find_by slug: params[:project_id]
    @item = @project.items.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |f|
        f.html { redirect_to account_project_path(current_account, set_project)}
        f.js
      end
      flash[:notice] = "An item is created."
    else
      flash.now[:alert] = "Something is wrong."
      render "new"
    end
  end

  def index
    @items = set_project.items.all
    respond_with(@items)
  end

  def show; end

  def edit; end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "You have updated the item."

       redirect_to [current_account, set_project, @item]

      
    else
      flash.now[:alert] = "Something's wrong."
      render "edit"
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "You have deleted your item."
    redirect_to account_project_path(current_account, set_project)
  end

  private

  def item_params
    params.require(:item).permit(:term, :name, :content, :image, :project_id, :account_id, detail_ids: [], details_attributes: [:id, :name, :description, :value, :_destroy ])
  end

  def set_item
    @item = set_project.items.find_by slug: params[:item_id]
  end
  helper_method :set_item

  def set_item
    @item = Item.find_by slug: params[:id]
  end


  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
    # Project.find_by slug: params[:id]
  end
  helper_method :set_project

end
