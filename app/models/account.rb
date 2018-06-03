class Account < ApplicationRecord
  before_create :generate_random_id

  include PgSearch
  multisearchable against: [:name],
    using: {
      tsearch: {
        prefix: true,
        highlight: {
          start_sel: '<b style="background-color:yellow;">',
          stop_sel: '</b>'
        }
      }
    }

  belongs_to :owner, class_name: "User", optional: true
  accepts_nested_attributes_for :owner

  has_many :invitations

  has_many :memberships
  has_many :users, through: :memberships

  has_many :projects
  has_many :subscription_events

  belongs_to :plan

  def stripe_customer
    return Stripe::Customer.retrieve(stripe_id) if stripe_id?
    stripe_customer = Stripe::Customer.create(email: email)
    update(stripe_id: stripe_customer.id)
    stripe_customer
  end

  def subscribed?
    stripe_subscription_id.present?
  end

  def over_limit_for?(plan)
    projects.count > plan.projects_allowed rescue 0
  end

  def generate_random_id
    begin
      self.id = SecureRandom.random_number(1_000_0000)
    end while Account.where(id: self.id).exists?
  end

  # before_save :generate_slug
  #
  # def generate_slug
  #   self.slug = self.name.gsub(" ", "-").downcase
  # end
  #
  # def to_param
  #   self.slug
  # end
end
