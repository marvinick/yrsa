class AddDetailIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :detail_id, :integer
  end
end
