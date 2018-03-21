NotificationsController < ApplicationController
  def index
    @notifications = @target.notifications
  end
end
