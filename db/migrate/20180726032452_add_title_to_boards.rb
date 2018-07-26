class AddTitleToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :title, :string
  end
end
