class AddUserIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :user_id, :integer, foreign_key: true
  end
end
