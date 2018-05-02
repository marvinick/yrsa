class AddIsBasicToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :is_basic, :boolean, default: true
  end
end
