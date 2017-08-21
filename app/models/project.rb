class Project < ApplicationRecord
  belongs_to :account, optional: true

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :items

  def as_json(options={})
    super(methods: [:email])
  end

  def email
    author.email
  end
end
