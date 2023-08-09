class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :consultation, null: false, foreign_key: { to_table: :consultations }
      t.text :content, null: false
      t.datetime :sent_at, null: false
      t.boolean :is_read, null: false, default: false
      t.timestamps
    end
  end
end
