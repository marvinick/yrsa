class ErrorsController < ActionController::Base
  protect_from_forgery with: :null_session

  def not_found
    flash[:alert] = "Seems like you're using a wrong url."
    redirect_to root_url
  end
end
