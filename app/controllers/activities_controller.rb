class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User")
    # @activities = PublicActivity::Activity.order("created_at DESC").where(trackable_type: "Review")
    # @activities = PublicActivity::Activity.all
  end
end
