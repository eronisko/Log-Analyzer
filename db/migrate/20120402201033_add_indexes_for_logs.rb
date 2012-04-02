class AddIndexesForLogs < ActiveRecord::Migration
  def up
    add_index :logs, [:investigation_id, :ignore_list_id, :source_id]
  end

  def down
    remove_index :logs, [:investigation_id, :ignore_list_id, :source_id]
  end
end
