class Review < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :user
  validates_uniqueness_of :user_id

  belongs_to :item, optional: true
  serialize :properties, Hash

  belongs_to :detail, optional: true
end
