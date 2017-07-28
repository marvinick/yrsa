class Invitation < ApplicationRecord
  belongs_to :account
  validates :email, presences: true
end
