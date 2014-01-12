class RemoveFighterAAndFighterBFromMatches < ActiveRecord::Migration
  def change
    remove_reference :matches, :fighter_a, index: true
    remove_reference :matches, :fighter_b, index: true
  end
end
