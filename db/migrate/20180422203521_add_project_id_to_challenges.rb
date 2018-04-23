class AddProjectIdToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :project_id, :integer
    add_column :challenges, :user_id, :integer
  end
end
