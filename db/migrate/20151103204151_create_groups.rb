class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.integer :order_id
    	t.string :name
    	t.string :price

      t.timestamps null: false
    end
  end
end
