class SubscriptionEvent < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :account

  def self.process_webhook(type, data)
  end
end
