class CreateEliminationLists < ActiveRecord::Migration
  def change
    create_table :elimination_lists do |t|
      t.string :name
      t.string :description
      t.string :pattern_list

      t.timestamps
    end
  end
end
