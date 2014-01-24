class AddColumnDisplayToActions < ActiveRecord::Migration
  def change
    add_column :actions, :column_display, :string
  end
end
