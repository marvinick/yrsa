class Respond < ApplicationRecord
  belongs_to :board
  belongs_to :challenge
  belongs_to :review

  validates_presence_of :content
end
