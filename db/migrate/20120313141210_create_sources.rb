class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :description
      t.string :timestamp_definition
      t.string :field_1_name
      t.string :field_1_definition

      t.timestamps
    end
  end
end
