class AddImageProcessingToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :image_processing, :boolean
  end
end
