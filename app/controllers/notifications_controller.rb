class NotificationsController < ApplicationController
  # before_action :autheticate_user!
  before_action :set_notifications

  respond_to :html, :json

  def index

  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
    # if params[:id]
    #   @notification = Notification.find(params[:id])
    #   @notification.update_attribute(:read_at, Time.zone.now)
    # else
    #   @notifications.update_all(:read_at, Time.zone.now)
    # end
    #
    # respond_to do |format|
    #   format.js
    #   format.json { render json: { success: true } }
    # end
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user)
  end
end
