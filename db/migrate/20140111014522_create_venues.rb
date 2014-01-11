class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :street_address
      t.string :extended_address
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
