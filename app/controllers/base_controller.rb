class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!
  before_action :authorize_owner!
  before_action :subscription_required!
  before_action :active_subscription_required!
  before_action :check_stripe_subscription_id?

  def check_stripe_subscription_id?
    if current_account.stripe_subscription_id.blank?
      redirect_to account_choose_plan_url(current_account)
    end
  end

  def current_account
    @current_account ||= Account.find_by slug: params[:account_id]
  end
  helper_method :current_account

  def owner?
    current_account.owner == current_user
  end
  helper_method :owner?

  def basic_account?
    current_account.is_basic
  end
  helper_method :basic_account?

  private

  def subscription_required!
    return unless owner?
    if current_account.stripe_customer_id.blank?
      message = "You need to subscribe to a plan before using the account."
      flash[:alert] = message
      redirect_to account_choose_plan_url
    end
  end

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

  def active_subscription_required!
    return if !current_account.stripe_customer_id.blank? || current_account.stripe_subscription_status == "active"
    flash[:alert] = "This account is currently disabled due to an unpaid subscription."
    if owner?
      flash[:alert] = "Please update your payment details to re-activate your subscription."
      # redirect_to account_billing_url
      redirect_to root_url

    else
      flash[:alert] += " Please contact the account owner."
      redirect_to root_url
    end
  end
end
