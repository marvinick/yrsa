class AddIsPrivateToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :is_private, :boolean, default: true
  end
end
