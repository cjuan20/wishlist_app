class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
    	t.string :name
    	t.string :image
    	t.string :price
    	t.string :url
    	t.string :stock

    end
  end
end
