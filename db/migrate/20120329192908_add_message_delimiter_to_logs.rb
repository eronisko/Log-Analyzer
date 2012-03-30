class AddMessageDelimiterToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :message_delimiter, :string
  end
end
