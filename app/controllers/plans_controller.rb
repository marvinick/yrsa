class PlansController < BaseController
  skip_before_action :subscription_required!

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
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id).delete
    if subscription.status == "canceled"
      current_account.update_column(:stripe_subscription_id, nil)
      flash[:notice] = "Your subscription has been cancelled."
      redirect_to root_url
    end
  end

  def switch
    plan = Plan.find(params[:plan_id])
    customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id)
    subscription.plan = plan.stripe_id
    subscription.save
    current_account.update_column(:plan_id, plan.id)
    flash[:notice] = "You have changed to the #{plan.name} plan."
    redirect_to root_url
  end
end
