class Challenge < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :photos, dependent: :destroy
end
