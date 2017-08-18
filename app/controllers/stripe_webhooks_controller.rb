class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    head :ok
  end 
end
