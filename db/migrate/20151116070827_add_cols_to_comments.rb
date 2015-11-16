class AddColsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :post_id, :integer
    add_column :comments, :ancestry, :string

    add_index :comments, :ancestry
  end
end
