class CreatePostStatus < ActiveRecord::Migration  
  def change
    #drop_table :post

    create_table :post_statuses do |t|
      t.column :title, :string, :default => 1
    end
  end
end
