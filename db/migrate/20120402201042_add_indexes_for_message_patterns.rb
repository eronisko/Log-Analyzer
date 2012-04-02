class AddIndexesForMessagePatterns < ActiveRecord::Migration
  def up
    add_index :message_patterns, :source_id
  end

  def down
    remove_index :message_patterns, :source_id
  end
end
