class CreateUserConsents < ActiveRecord::Migration[5.1]
  def change
    create_table :user_consents do |t|
      t.references :user, foreign_key: true
      t.references :consent, foreign_key: true
      t.boolean :agreed

      t.timestamps
    end
  end
end
