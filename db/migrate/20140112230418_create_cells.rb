class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|

      t.timestamps
    end
  end
end
