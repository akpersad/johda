class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.integer :order_id
    	t.string :name
    	t.string :price

      t.timestamps null: false
    end
  end
end
