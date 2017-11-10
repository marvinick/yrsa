class BillingsController < BaseController
  skip_before_action :active_subscription_required!

  def payment_details
  end

  def update_payment_details
    @customer = Stripe::Customer.retrieve(current_account.stripe_customer_id)
    @customer.source = params[:token]
    @customer.save
    flash[:notice] = "Your payment details have been updated."
    redirect_to account_billing_path(current_account)
  end
end
