class Project < ApplicationRecord
  include PgSearch
  multisearchable against: [:title]
  # pg_search_scope :search_name, :against => [:title], using: { tsearch: { prefix: true } }

  belongs_to :account, optional: true

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :items

  has_many :boards

  validates :description, length: {minimum: 5, maximum: 280}, allow_blank: false

  def as_json(options={})
    super(methods: [:email])
  end

  def email
    author.email
  end

  before_save :generate_slug

  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
