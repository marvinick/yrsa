class CreateDetailItems < ActiveRecord::Migration[5.0]
  def change
    create_table :detail_items do |t|
      t.integer :detail_id
      t.integer :item_id
      t.timestamps
    end
  end
end
