class CreateListsAndUsers < ActiveRecord::Migration
  def change
    create_table :lists_and_users do |t|
    	t.belongs_to :list, index: true
    	t.belongs_to :user, index: true
    end
  end
end
