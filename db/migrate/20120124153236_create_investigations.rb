class CreateInvestigations < ActiveRecord::Migration
  def change
    create_table :investigations do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
