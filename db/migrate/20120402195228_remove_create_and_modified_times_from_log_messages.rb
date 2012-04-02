class RemoveCreateAndModifiedTimesFromLogMessages < ActiveRecord::Migration
  def change
    remove_columns :log_messages, :created_at, :updated_at
  end
end
