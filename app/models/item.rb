class Item < ApplicationRecord
  belongs_to :project, optional: true
  has_many :details, dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true, reject_if: ->(attrs) { attrs['name'].blank? || attrs['description'].blank? }
  has_attached_file :image
end
