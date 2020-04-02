class CreateUserTempChat < ActiveRecord::Migration[6.0]
  def change
    create_table :user_temp_chats do |t|
      t.string :line_user_id, null: false
      t.string :message, null: false
      t.string :intent_name, null: false

      t.timestamps
    end
  end
end
