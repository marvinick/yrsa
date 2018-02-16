class Project < ApplicationRecord
  include PgSearch
  multisearchable against: [:title, :description],
    using: {
      tsearch: {
        prefix: true,
        highlight: {
          start_sel: '<b>',
          stop_sel: '</b>'
        }
      }
    }
  # pg_search_scope :search_name, :against => [:title], using: { tsearch: { prefix: true } }

  belongs_to :account, optional: true

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :details

  has_many :items

  has_many :boards

  has_many :invitations

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
