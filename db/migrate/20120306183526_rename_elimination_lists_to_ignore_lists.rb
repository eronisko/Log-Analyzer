class RenameEliminationListsToIgnoreLists < ActiveRecord::Migration
  def change
    rename_table :elimination_lists, :ignore_lists
  end
end
