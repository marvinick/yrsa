class AddProjectIdToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :project_id, :integer
  end
end
