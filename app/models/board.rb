class Board < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :detail_id
  belongs_to :item_id

  has_attached_file :photo, :styles => { :medium => "300x300#", :thumb => "200x200#" }
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates_presence_of :note
  validates :note, length: {minimum: 5}, allow_blank: false

  def day
    self.created_at.strftime('%B %d, %Y')
  end

end
