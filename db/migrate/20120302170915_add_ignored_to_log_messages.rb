class AddIgnoredToLogMessages < ActiveRecord::Migration
  def change
    add_column :log_messages, :ignored, :boolean, default: false
  end
end
