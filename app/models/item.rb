class Item < ApplicationRecord
  include PgSearch
  multisearchable against: :name

  belongs_to :project, optional: true

  has_many :details, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :details, allow_destroy: true, reject_if: ->(attrs) { attrs['name'].blank? || attrs['description'].blank? }

  has_attached_file :image, styles: {
    large: "300x150#",
    xlarge: "500x300#"
  }

  validates_presence_of :name
  validates :content, length: {minimum: 5, maximum: 280}, allow_blank: false

  validates_attachment_content_type :image,
		content_type:  /^image\/(png|gif|jpeg)/,
		message: "Only images allowed"

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 10.megabytes

  process_in_background :image, processing_image_url: "/images/:style/cartoon.png"

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
