class RenamePathToFile < ActiveRecord::Migration
  def change
    rename_column :logs, :path, :file
  end
end
