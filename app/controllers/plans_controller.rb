class PlansController < BaseController
  skip_before_action :subscription_required!
  skip_before_action :check_stripe_subscription_id?
  rescue_from Stripe::InvalidRequestError, with: :stripe_error_handling

  def choose
    @plans = Plan.order(:amount)
  end

  def chosen
    customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    plan = Plan.find(params[:account][:plan_id])

    subscription = customer.subscriptions.create(
      plan: plan.stripe_id,
      source: params[:token]
    )
    current_account.plan_id = params[:account][:plan_id]
    current_account.stripe_subscription_id = subscription.id
    current_account.save
    flash[:notice] = "Your account has been created."
    redirect_to root_url
  end

  def cancel
    customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id).delete(at_period_end: true)
    #addition from drifting ruby
    # expires_at = Time.at(subscription.current_period_end)
    # current_account.update_column(:stripe_subscription_id, nil, expires_at: expires_at)
    if subscription.status == "canceled"
      current_account.update_column(:stripe_subscription_id, nil)
      flash[:notice] = "Your subscription has been cancelled."
      redirect_to root_url
    end
  end

  def unsubscribe
    customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id).delete(at_period_end: true)
    expires_at = Time.at(subscription.current_period_end)
    if subscription.status == "canceled"
      current_account.update_column(:stripe_subscription_id, nil)
      flash[:notice] = "Your subscription has been cancelled."
      redirect_to root_path, notice: "You have cancelled your subscription. You will have access until #{l  current_user.expires_at.to_date, format: :long}."
    end
  end

  def resubscribe
    subscription = current_account.stripe_customer.subscriptions.first
    if subscription.save
      current_account.update(stripe_subscription_id: subscription.id, expires_at: nil)
      flash.notice = "Thanks for resubscribing!"
    else
      flash.alert = "There was a problem resubscribing!"
    end
    redirect_to root_path
  end

  def switch
    plan = Plan.find(params[:plan_id])
    if current_account.over_limit_for?(plan)
      flash[:alert] = "You cannot switch to that plan." + " Your account is over that plan's limit."
      redirect_to account_choose_plan_path
      return
    end
    plan = Plan.find(params[:plan_id])
    customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id)
    subscription.plan = plan.stripe_id
    subscription.save

    current_account.update_column(:plan_id, plan.id)

    flash[:notice] = "You have changed to the #{plan.name} plan."
    redirect_to root_url
  end

  private

  def stripe_error_handling
    flash[:alert] = "Please update your payment details first before upgrading your plan to Pro."
    redirect_to account_billing_path(current_account)
  end
end
