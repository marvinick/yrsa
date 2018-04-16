class CreateResponds < ActiveRecord::Migration[5.0]
  def change
    create_table :responds do |t|
      t.text :content
      t.integer :board_id
      t.integer :challenge_id
      t.integer :review_id

      t.timestamps
    end
  end
end
