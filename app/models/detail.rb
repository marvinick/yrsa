class Detail < ApplicationRecord
  belongs_to :item, optional: true
  has_many :reviews
end
