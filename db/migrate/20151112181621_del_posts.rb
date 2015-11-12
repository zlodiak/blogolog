class DelPosts < ActiveRecord::Migration
  def change
    drop_table :posts
  end
end
