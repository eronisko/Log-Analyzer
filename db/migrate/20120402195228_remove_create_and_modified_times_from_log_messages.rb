class RemoveCreateAndModifiedTimesFromLogMessages < ActiveRecord::Migration
  def up
    remove_timestamps :log_messages
  end

  def down
    add_timestamps :log_messages
  end
end
