class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :cell, index: true
      t.references :action, index: true

      t.timestamps
    end
  end
end
