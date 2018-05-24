module Subscriptions
  class ResubscribesController < BaseController
    def new
      subscription = current_user.stripe_customer.subscriptions.first
      if subscription.save
        current_user.update(stripe_subscription_id: subscription.id, expires_at: nil)
        flash.notice = "Thanks for resubscribing!"
      else
        flash.alert = "There was a problem resubscribing!"
      end
      redirect_to root_path
    end
  end
end
