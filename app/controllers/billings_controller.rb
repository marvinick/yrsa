class BillingsController < BaseController
  skip_before_action :active_subscription_required!

  def payment_details
  end
end
