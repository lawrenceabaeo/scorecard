class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :fighter_a, index: true
      t.references :fighter_b, index: true
      t.datetime :original_fight_date
      t.references :venue, index: true
      t.integer :total_rounds

      t.timestamps
    end
  end
end
