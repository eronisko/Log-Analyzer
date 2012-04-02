class AddIndexesForLogMessages < ActiveRecord::Migration
  def up
    add_index :log_messages, [:log_id, :message_pattern_id]
  end

  def down
    remove_index :log_messages, [:log_id, :message_pattern_id]
  end
end
