class ReviewsController < BaseController
  before_action :set_review, except: [:new, :create]

  def new
    project = Project.find(params[:project_id])
    @item = project.items.find(params[:item_id])
    @detail = @item.details.find(params[:detail_id])
    @review = @detail.reviews.build
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "You've submitted a review."
      redirect_to  account_project_item_detail_path(current_account, set_project, @item, @detail)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def review_params
    params.require(:review).permit(:description, :value, :detail_id)
  end

  def set_review
    project = Project.find(params[:project_id])
    @item = project.items.find(params[:item_id])
    @detail = @item.details.find(params[:detail_id])
    @review = @detail.reviews.find(params[:id])
  end
    
  def set_project
    project = Project.find(params[:project_id])
  end
  helper_method :set_project
end
