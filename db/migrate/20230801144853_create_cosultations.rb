class CreateCosultations < ActiveRecord::Migration[7.0]
  def change
    create_table :cosultations do |t|
      t.integer :consultant_id
      t.integer :requester_id
      t.text :request_content
      t.datetime :answer_deadline
      t.string :status
      t.boolean :is_read, default: false
      t.string :talk_room_status

      t.timestamps
    end
  end
end
