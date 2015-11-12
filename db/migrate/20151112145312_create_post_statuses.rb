class CreatePostStatuses < ActiveRecord::Migration
  def change
    create_table :post_statuses do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
