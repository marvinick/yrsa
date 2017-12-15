class Account < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: true
  accepts_nested_attributes_for :owner

  has_many :invitations

  has_many :memberships
  has_many :users, through: :memberships

  has_many :projects
  has_many :subscription_events

  belongs_to :plan, optional: true

  def subscribed?
    stripe_subscription_id.present?
  end

  def over_limit_for?(plan)
    projects.count > plan.projects_allowed
  end

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
