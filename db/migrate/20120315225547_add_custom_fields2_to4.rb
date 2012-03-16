class AddCustomFields2To4 < ActiveRecord::Migration
  def change
    add_column :log_messages, :field_2, :string
    add_column :log_messages, :field_3, :string
    add_column :log_messages, :field_4, :string
    add_column :sources, :field_2_name, :string
    add_column :sources, :field_2_definition, :string
    add_column :sources, :field_3_name, :string
    add_column :sources, :field_3_definition, :string
    add_column :sources, :field_4_name, :string
    add_column :sources, :field_4_definition, :string
  end
end
