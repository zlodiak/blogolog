class AddNotNullToUserTitle < ActiveRecord::Migration
  def change
    remove_column :users, :title
    add_column :users, :title, :string, :default => 0, :null => false
  end
end
