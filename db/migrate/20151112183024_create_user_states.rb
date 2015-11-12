class CreateUserStates < ActiveRecord::Migration
  def change
    create_table :user_states do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
