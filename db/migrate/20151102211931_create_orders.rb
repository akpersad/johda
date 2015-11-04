class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :name
    	t.integer :user_id
    	t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
