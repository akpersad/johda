class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    	t.integer :merchant_id
    	t.string :name
    	t.string :address
    	t.float :lat
    	t.float :long
    	t.boolean :is_it_open
    	t.time :last_or_next_order_time
    	t.float :delivery_charge
    	t.string :cuisine
    	t.integer :phonenumber, :limit => 5
      t.timestamps null: false
    end
  end
end
