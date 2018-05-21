class AddDisplayedToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :displayed, :boolean
  end
end
