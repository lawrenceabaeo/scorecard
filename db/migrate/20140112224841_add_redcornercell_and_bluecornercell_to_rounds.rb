class AddRedcornercellAndBluecornercellToRounds < ActiveRecord::Migration
  def change
    add_reference :rounds, :redcornercell, index: false
    add_reference :rounds, :bluecornercell, index: false
  end
end
