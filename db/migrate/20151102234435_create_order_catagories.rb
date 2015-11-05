class CreateOrderCatagories < ActiveRecord::Migration
  def change
    create_table :order_catagories do |t|
    	t.integer :order_id
    	t.integer :catagory_id
    	

      t.timestamps null: false
    end
  end
end
