class Board < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :detail_id
  belongs_to :item_id

  has_many :photos, dependent: :destroy

  validates_presence_of :note
  validates :note, length: {minimum: 5}, allow_blank: false

  def day
    self.created_at.strftime('%B %d, %Y')
  end

end
