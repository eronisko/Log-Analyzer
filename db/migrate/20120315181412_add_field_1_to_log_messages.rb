class AddField1ToLogMessages < ActiveRecord::Migration
  def change
    add_column :log_messages, :field_1, :string
  end
end
