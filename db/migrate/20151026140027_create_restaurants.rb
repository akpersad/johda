class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    	t.integer :merchant_id
    	t.string :name
    	t.string :address
    	t.float :lat
    	t.float :long
    	t.boolean :is_it_open
    	t.time :open_time
    	t.time :close_time
    	t.float :delivery_charge
    	t.integer :rating
    	t.string :cuisine
    	t.integer :rating
    	t.integer :phonenumber, :limit => 5
      t.timestamps null: false
    end
  end
end
