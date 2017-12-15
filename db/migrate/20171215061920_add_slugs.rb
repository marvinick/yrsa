class AddSlugs < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :slug, :string
    add_column :items, :slug, :string
  end
end
