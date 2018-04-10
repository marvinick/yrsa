class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.datetime :due_date
      t.timestamps
    end
  end
end
