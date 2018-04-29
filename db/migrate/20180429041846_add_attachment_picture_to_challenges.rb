class AddAttachmentPictureToChallenges < ActiveRecord::Migration[5.0]
  def self.up
    change_table :challenges do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :challenges, :picture
  end
end
