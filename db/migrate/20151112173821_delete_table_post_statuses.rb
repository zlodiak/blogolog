class DeleteTablePostStatuses < ActiveRecord::Migration
  def change
    drop_table :post_statuses
  end
end
