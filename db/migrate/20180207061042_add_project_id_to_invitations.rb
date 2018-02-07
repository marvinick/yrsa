class AddProjectIdToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :project_id, :integer, foreign_key: true
  end
end
