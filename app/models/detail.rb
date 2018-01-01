class Detail < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :project
  has_many :reviews

  validates_presence_of :name
  validates :name, length: {minimum: 1, maximum: 20}, allow_blank: false
end
