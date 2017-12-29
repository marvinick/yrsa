class Detail < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :project
  has_many :reviews

  validates_presence_of :name
end
