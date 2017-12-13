class Review < ApplicationRecord
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked

  belongs_to :user

  belongs_to :item, optional: true
  serialize :properties, Hash
end
