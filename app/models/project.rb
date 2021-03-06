class Project < ApplicationRecord
  before_create :generate_random_id

  include PgSearch

  multisearchable against: [:title],
    using: {
      tsearch: {
        prefix: true,
        highlight: {
          start_sel: '<b style="background-color:yellow;">',
          stop_sel: '</b>'
        }
      }
    }

  validates_length_of :description, :minimum => 30
  belongs_to :account, optional: true

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :details

  has_many :items

  has_many :boards

  has_many :invitations

  has_many :challenges

  def generate_random_id
    begin
      self.id = SecureRandom.random_number(1_000_0000)
    end while Project.where(id: self.id).exists?
  end

  # def as_json(options={})
  #   super(methods: [:email])
  # end
  #
  # def email
  #   author.email
  # end

  # before_save :generate_slug
  #
  # def generate_slug
  #   self.slug = self.title.gsub(" ", "-").downcase
  # end
  #
  # def to_param
  #   self.slug
  # end
end
