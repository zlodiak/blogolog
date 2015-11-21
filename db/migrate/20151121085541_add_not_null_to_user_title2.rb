class AddNotNullToUserTitle2 < ActiveRecord::Migration
  def change
    remove_column :users, :title
    add_column :users, :title, :string, :default => 'Anonymous', :null => false    
  end
end
