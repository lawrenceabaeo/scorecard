class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :match, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
