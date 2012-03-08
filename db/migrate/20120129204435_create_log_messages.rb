class CreateLogMessages < ActiveRecord::Migration
  def change
    create_table :log_messages do |t|
      t.integer :log_id
      t.string :raw_message

      t.timestamps
    end
  end
end
