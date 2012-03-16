class AddTimestampToLogMessages < ActiveRecord::Migration
  def change
    add_column :log_messages, :timestamp, :string
  end
end
