class Review < ApplicationRecord
  belongs_to :user
  belongs_to :detail, optional: true
end
