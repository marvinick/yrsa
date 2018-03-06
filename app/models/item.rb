class Item < ApplicationRecord

  include PgSearch
  multisearchable against: [:name, :content],
    using: {
      tsearch: {
        prefix: true
      }
    }

  belongs_to :project, optional: true

  has_many :detail_items
  has_many :details, through: :detail_items
  has_many :details, dependent: :nullify

  has_many :reviews, dependent: :destroy

  validates_presence_of :name, length: {minimum: 5, maximum: 20}, allow_blank: false
  validates :content, length: {minimum: 5, maximum: 280}, allow_blank: false
  validates_uniqueness_of :name

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
