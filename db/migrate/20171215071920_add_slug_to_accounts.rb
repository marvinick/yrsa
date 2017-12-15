class AddSlugToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :slug, :string
  end
end
