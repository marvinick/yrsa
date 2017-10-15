class Item < ApplicationRecord
  belongs_to :project, optional: true
  has_many :details, dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true, reject_if: ->(attrs) { attrs['name'].blank? || attrs['description'].blank? }
  has_attached_file :image, styles: { small: "64x64#", med: "200x100#", large: "320x200#", xlarge: "800x600#" }

  validates_attachment_content_type :image,
		content_type:  /^image\/(png|gif|jpeg)/,
		message: "Only images allowed"

    validates :image, attachment_presence: true
end
