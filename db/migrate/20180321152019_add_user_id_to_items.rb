class AddUserIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :user_id, :integer, foreign_key: true
  end
end
