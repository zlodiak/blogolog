class Rename < ActiveRecord::Migration
  def change
    rename_table(:user_states, :user_statuses)
  end
end
