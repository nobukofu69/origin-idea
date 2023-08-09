class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.references :consultant, null: false, foreign_key: { to_table: :users }
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.text :request_content, null: false
      t.datetime :answer_deadline, null: false
      t.integer :request_status, null: false, default: 0
      t.integer :talkroom_status, null: false, default: 0
      t.boolean :is_read, null: false, default: false
      t.timestamps
    end
  end
end
