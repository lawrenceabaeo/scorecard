class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :card, index: true
      t.integer :round_number
      t.references :fighter, index: true
      t.references :action, index: true

      t.timestamps
    end
  end
end
