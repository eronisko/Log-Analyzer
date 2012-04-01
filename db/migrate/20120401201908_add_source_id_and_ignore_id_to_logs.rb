class AddSourceIdAndIgnoreIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :ignore_list_id, :integer
    add_column :logs, :source_id, :integer
  end
end
