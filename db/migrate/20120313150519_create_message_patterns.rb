class CreateMessagePatterns < ActiveRecord::Migration
  def change
    create_table :message_patterns do |t|
      t.integer :source_id
      t.string :name
      t.string :pattern
      t.string :category

      t.timestamps
    end
  end
end
