class AddLinkToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :link, :string
  end
end
