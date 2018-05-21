class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery with: :null_session
  :use_growlyflash

  include PublicActivity::StoreController

  def current_account
    nil
  end
  helper_method :current_account

  private

  def record_not_found
    flash[:alert] = "Unauthorized access."
    redirect_to root_url
  end
end
