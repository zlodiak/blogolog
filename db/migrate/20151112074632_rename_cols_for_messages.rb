class RenameColsForMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :author_anon, :anon_author_name
    rename_column :messages, :author_user, :user_author_id
  end
end
