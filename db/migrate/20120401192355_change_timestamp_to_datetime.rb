class ChangeTimestampToDatetime < ActiveRecord::Migration
  def change
    change_column :log_messages, :timestamp, :datetime
  end
end
