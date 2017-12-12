class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User")
  end
end
