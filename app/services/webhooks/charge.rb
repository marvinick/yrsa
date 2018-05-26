module Webhooks
  class Charge
    def initialize(event)
      @event = event
    end

    def call
      case @event.type
      when 'charge.succeeded'
        charge_succeeded
      when 'charge.failed'
        charge_failed
      end
    end

    private

    def charge_succeeded
      charge = @event.data.object
      user = User.find_by(stripe_id: charge.customer)
      new_charge = user.charges.where(stripe_id: charge.id).first_or_create
      new_charge.update(
        amount: charge.amount,
        card_brand: charge.source.brand,
        card_last4: charge.source.last4,
        card_exp_month: charge.source.exp_month,
        card_exp_year: charge.source.exp_year
      )
    end

    def charge_failed
      charge = @event.data.object
      user = User.find_by(stripe_id: charge.customer)
      user.update(expires_at: Time.current - 1.hour, stripe_subscription_id: nil)
    end
  end
end
