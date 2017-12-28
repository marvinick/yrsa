class AddProjectIdToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :project_id, :integer
  end
end
