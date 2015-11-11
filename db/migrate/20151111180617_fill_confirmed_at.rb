class FillConfirmedAt < ActiveRecord::Migration
  def change
    execute("UPDATE users SET confirmed_at = '2015-10-19 14:00:28.327015'")
  end
end



