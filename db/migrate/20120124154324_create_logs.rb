class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :investigation_id
      t.string :name
      t.string :description
      t.string :data_type
      t.string :path
      t.integer :time_bias

      t.timestamps
    end
  end
end
