class Detail < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :project
  has_many :reviews
end
