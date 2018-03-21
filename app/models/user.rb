class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_projects
  has_many :projects, through: :user_projects

  has_many :memberships
  has_many :accounts, through: :memberships

  has_many :reviews, dependent: :destroy \

  def owned_accounts
    Account.where(owner: self)
  end

  def all_accounts
    owned_accounts + accounts
  end

  has_many :notifications, foreign_key: :recipient_id 
end
