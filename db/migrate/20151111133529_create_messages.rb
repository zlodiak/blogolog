class CreateMessages < ActiveRecord::Migration
  def change  
    create_table :messages do |t|
      t.string :author_anon
      t.integer :author_user
      t.string :title
      t.text :body
      t.string :email

      t.timestamps null: false
    end
  end
end
