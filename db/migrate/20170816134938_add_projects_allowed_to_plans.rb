class AddProjectsAllowedToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :projects_allowed, :integer
  end
end
