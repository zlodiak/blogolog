class AddUserIdToPost < ActiveRecord::Migration
  def change
    remove_column :users, :user_id
    add_column :posts, :user_id, :integer
  end
end
