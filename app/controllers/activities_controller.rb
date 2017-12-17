class ActivitiesController < BaseController
  skip_before_action :authorize_user!
  skip_before_action :authorize_owner!
  skip_before_action :subscription_required!
  skip_before_action :active_subscription_required!
  skip_before_action :check_stripe_subscription_id?

  def index
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User")
    # @activities = PublicActivity::Activity.order("created_at DESC").where(trackable_type: "Review")
    # @activities = PublicActivity::Activity.all
  end

  private

  def set_review
    @review = set_item.reviews.find(params[:id])
  end
  helper_method :set_review

  def set_item
    @item = set_project.items.find_by slug: params[:item_id]
  end
  helper_method :set_item

  def set_project
    project = Project.find_by slug: params[:project_id]
  end
  helper_method :set_project
end
