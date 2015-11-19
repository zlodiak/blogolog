class RenameUserIdToCommentIdInCommentLikes < ActiveRecord::Migration
  def change
    rename_column :comment_likes, :post_id, :comment_id
  end
end
