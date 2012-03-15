class AddMessagePatternIdToLogMessages < ActiveRecord::Migration
  def change
    add_column :log_messages, :message_pattern_id, :integer
  end
end
