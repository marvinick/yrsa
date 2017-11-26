class Item < ApplicationRecord
  include PgSearch
  multisearchable against: :name
  # pg_search_scope :search_name, :against => [:name], using: { tsearch: { prefix: true } }

  belongs_to :project, optional: true

  has_many :details, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true, reject_if: ->(attrs) { attrs['name'].blank? || attrs['description'].blank? }

  has_attached_file :image, styles: {
    large: "300x150#",
    xlarge: "500x300#"
  }

  validates_attachment_content_type :image,
		content_type:  /^image\/(png|gif|jpeg)/,
		message: "Only images allowed"

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 10.megabytes


  process_in_background :image
end
