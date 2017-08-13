class Account < ApplicationRecord
  belongs_to :owner, class_name: "User"
  accepts_nested_attributes_for :owner

  belongs_to :plan

  has_many :invitations

  has_many :memberships
  has_many :users, through: :memberships

  has_many :projects
end
