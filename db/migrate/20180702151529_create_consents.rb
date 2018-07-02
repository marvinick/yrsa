class CreateConsents < ActiveRecord::Migration[5.1]
  def change
    create_table :consents do |t|
      t.string :name
      t.boolean :mandatory
      t.text :description

      t.timestamps
    end
  end
end
