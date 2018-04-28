class Item < ApplicationRecord
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

  # has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "200x200#" }
  # validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  belongs_to :project, optional: true

  has_many :detail_items
  has_many :details, through: :detail_items
  has_many :details, dependent: :nullify

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates_presence_of :name, length: {minimum: 5, maximum: 20}, allow_blank: false
  validates :content, length: {minimum: 5}, allow_blank: false
  validates_uniqueness_of :name

  has_many :photos, dependent: :destroy

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
