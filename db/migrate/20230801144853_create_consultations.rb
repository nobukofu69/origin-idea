class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.references :consultant, null: false, foreign_key: { to_table: :users }
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.text :request_content
      t.datetime :answer_deadline
      t.integer :status, default: 0
      t.boolean :is_read, default: false
      t.boolean :talk_room_open, default: false

      t.timestamps
    end
  end
end
