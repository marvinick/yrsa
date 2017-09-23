class ApplicationController < ActionController::Base
  use_growlyflash
  protect_from_forgery with: :null_session

  def current_account
    nil
  end
  helper_method :current_account
end
