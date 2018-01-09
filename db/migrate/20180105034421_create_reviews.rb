class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :business_id
      t.text :description
    end
  end
end
