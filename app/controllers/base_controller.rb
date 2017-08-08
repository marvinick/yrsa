class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!
  before_action :authorize_owner!

  def current_account
    @current_account ||= Account.find(params[:account_id])
  end
  helper_method :current_account

  def owner?
    current_account.owner == current_user
  end
  helper_method :owner?

  private

  def authorize_owner!
    unless owner?
      flash[:alert] = "Only an owner of the account can do that."
      redirect_to root_url
    end
  end

  def authorize_user!
    authenticate_user!
    unless  current_account.owner == current_user ||
            current_account.users.exists?(current_user.id)
      flash[:notice] = "You are not permitted to view that account."
      redirect_to root_url
    end
  end
end
