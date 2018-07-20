class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.string :master_id
      t.integer :max_count
      t.integer :admission_count

      t.timestamps null: false
    end
  end
end
