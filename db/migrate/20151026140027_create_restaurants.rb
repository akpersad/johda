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
        t.string :time_needed
        t.integer :delivery_charge
        t.integer :min_order
        t.timestamps null: false
    end
  end
end
