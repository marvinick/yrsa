class AddAttachmentPhotoToBoards < ActiveRecord::Migration[5.0]
  def self.up
    change_table :boards do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :boards, :photo
  end
end
