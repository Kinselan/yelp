class AddSlugToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :slug, :string
  end
end
