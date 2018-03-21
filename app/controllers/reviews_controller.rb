class ReviewsController < BaseController
  include PublicActivity::StoreController
  after_create :create_notifications

  before_action :set_item
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!
  before_action :authorize_reviewer, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:edit, :update]
  respond_to :html, :json

  def new
    @review = set_item.reviews.build
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "You've submitted a review."
      redirect_to account_project_item_path(current_account, set_project, set_item)
    else
      render 'new'
    end
  end

  def index
    @reviews = set_item.reviews.all.order('created_at DESC')
  end

  def show; end

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
    redirect_to account_project_item_path(current_account, set_project, set_item)
  end

  def confirm; end

  private

  def recipients
  end

  def create_notifications
    recipients.each do |recipient|
      Notification.creat(recipient: recipient, actor: self.user, action: 'posted', notifiable: self)
    end
  end

  def authorize_reviewer
    if @review.user_id != current_user.id
      flash.now[:alert] = "You're not authorized to do that."
      redirect_to account_project_item_path(current_account, set_project, set_item)
    end
  end

  def review_params
    params.require(:review).tap do |whitelisted|
      whitelisted[:properties] = params[:review][:properties]
      whitelisted[:description] = params[:review][:description]
    end
  end

  def set_review
    @review = @item.reviews.find(params[:id])
  end
  helper_method :set_review

  def set_item
    @item = set_project.items.find_by slug: params[:item_id]
  end
  helper_method :set_item

  def set_project
    current_account.projects.find_by slug: params[:project_id]
  end
  helper_method :set_project

  def check_review_limit
    if set_review.user_id == current
      flash.now[:alert] = "You can only review once."
    end
  end

end
