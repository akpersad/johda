class CreateRestaurants < ActiveRecord::Migration
  def change
        create_table :restaurants do |t|
        t.integer :merchant_id
        t.string :name
        t.string :address
        t.string :phone_number
        t.string :cuisine
        t.string :logo
        t.integer :rating
        t.integer :price_rating
        t.string :rating_img
        t.timestamps null: false
    end
  end
end
