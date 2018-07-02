class UserConsent < ApplicationRecord
  belongs_to :user
  belongs_to :consent
end
