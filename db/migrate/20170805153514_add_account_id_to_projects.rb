class AddAccountIdToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :account_id, :integer
  end
end
