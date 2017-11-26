class Project < ApplicationRecord
  include PgSearch
  # multisearchable :against => [:title]
  pg_search_scope :search_name, :against => [:title]

  belongs_to :account, optional: true

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :items

  has_many :boards

  def as_json(options={})
    super(methods: [:email])
  end

  def email
    author.email
  end
end
