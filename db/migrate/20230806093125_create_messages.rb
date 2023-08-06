class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender_id, null: false, foreign_key: { to_table: :users }
      t.references :consultation_id, null: false, foreign_key: { to_table: :consultations }
      t.text :content
      t.boolean :is_read

      t.timestamps
    end
  end
end
