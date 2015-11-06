class CreateMenuComments < ActiveRecord::Migration
  def change
    create_table :menu_comments do |t|
    	t.integer :merch_id

      t.timestamps null: false
    end
  end
end
