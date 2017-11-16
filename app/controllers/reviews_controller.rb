class ReviewsController < BaseController
  before_action :set_review, except: [:new, :create]
  skip_before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @review = set_detail.reviews.build
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "You've submitted a review."
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @review.update_attributes(review_params)
      flash[:notice] = "You've updated the review."
      redirect_to account_project_item_path(current_account, set_project, set_item)
    else
      render "edit"
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "You have deleted your review."
    redirect_to account_project_item_detail_path(current_account, set_project, set_item, set_detail)
  end

  private

  def review_params
    params.require(:review).permit(:description, :value, :detail_id, :user_id)
  end

  def set_review
    @review = set_detail.reviews.find(params[:id])
  end
  helper_method :set_review

  def set_detail
    @detail = set_item.details.find(params[:detail_id])
  end
  helper_method :set_detail

  def set_item
    @item = set_project.items.find(params[:item_id])
  end
  helper_method :set_item

  def set_project
    project = Project.find(params[:project_id])
  end
  helper_method :set_project

  def check_review_limit

    if set_review.user_id == curren
      flash.now[:alert] = "You can only review once."
    end
  end

end
