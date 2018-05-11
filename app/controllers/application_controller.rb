class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  :use_growlyflash

  include PublicActivity::StoreController

  def current_account
    nil
  end
  helper_method :current_account
end
