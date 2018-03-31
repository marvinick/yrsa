class Review < ApplicationRecord
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked

  after_create :create_notifications

  belongs_to :user
  belongs_to :item, optional: true

  validates_presence_of :description
  validates_length_of :description, :minimum => 5, :maximum => 280, :allow_blank => false

  serialize :properties, Hash

  def recipients
    User.all
  end

  def create_notifications
    recipients.each do |recipient|
      Notification.create(recipient: recipient, actor: self.user, action: 'posted', notifiable: self)
    end
  end
end
