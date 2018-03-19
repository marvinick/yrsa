class Review < ApplicationRecord
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked

  belongs_to :user

  validates_presence_of :description
  validates_length_of :description, :minimum => 5, :maximum => 280, :allow_blank => false

  belongs_to :item, optional: true
  serialize :properties, Hash
end
 
