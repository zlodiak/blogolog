class AddUserStatusIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_status_id, :integer, default: 1
  end
end
