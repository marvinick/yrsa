module Subscriptions
  class UnsubsribesController < BaseController
    def destroy
    customer = current_user.stripe_customer
      subscription = customer.subscriptions
                              .retrieve(current_user.stripe_subscription_id)
                              .delete(at_period_end: true)
      expires_at = Time.at(subscription.current_period_end)
      current_user.update_attributes(stripe_subscription_id: nil, expires_at: expires_at)
      redirect_to root_path, notice: "You have cancelled your subscription. You will have access until #{l  current_user.expires_at.to_date, format: :long}."
    end
  end
end
