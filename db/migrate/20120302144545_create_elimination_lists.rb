class CreateIgnoreLists < ActiveRecord::Migration
  def change
    create_table :ignore_lists do |t|
      t.string :name
      t.string :description
      t.string :pattern_list

      t.timestamps
    end
  end
end
