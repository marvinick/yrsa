class NotificationsController < ApplicationController
  before_action :autheticate_user!
  before_action :set_notifications

  def index
    @notifications = @target.notifications
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user).unread
end
