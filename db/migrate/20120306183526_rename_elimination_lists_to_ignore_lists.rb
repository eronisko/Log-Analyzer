class RenameIgnoreListsToIgnoreLists < ActiveRecord::Migration
  def change
    rename_table :ignore_lists, :ignore_lists
  end
end
