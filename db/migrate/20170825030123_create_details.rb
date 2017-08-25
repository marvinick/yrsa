class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.belongs_to :item, foreign_key: true

      t.timestamps
    end
  end
end
