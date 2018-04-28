class AddBoardIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :board_id, :integer
    add_column :photos, :item_id, :integer
    add_column :photos, :challenge_id, :integer
  end
end
