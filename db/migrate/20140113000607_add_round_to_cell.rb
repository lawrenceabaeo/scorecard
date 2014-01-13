class AddRoundToCell < ActiveRecord::Migration
  def change
    add_reference :cells, :round, index: true
  end
end
