class PlansController < BaseController

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
end
