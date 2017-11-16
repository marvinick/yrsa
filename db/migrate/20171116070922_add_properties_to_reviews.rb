class AddPropertiesToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :properties, :text
  end
end
