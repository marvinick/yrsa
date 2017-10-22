class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  use_growlyflash
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  

  def current_account
    nil
  end
  helper_method :current_account
end
