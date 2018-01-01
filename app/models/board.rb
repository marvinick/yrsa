class Board < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :detail_id
  belongs_to :item_id

  validates_presence_of :note
  validates_length_of :note, :maximum => 280


  def day
    self.created_at.strftime('%B %d, %Y')
  end

end
