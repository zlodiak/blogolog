class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :body
      t.string :ancestry

      t.timestamps null: false
    end

    add_index :comments, :ancestry
  end
end
