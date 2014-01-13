class RemoveFighterAndActionFromRounds < ActiveRecord::Migration
  def change
    remove_reference :rounds, :fighter, index: true
    remove_reference :rounds, :action, index: true
  end
end
