class AddRedcornerAndBluecornerToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :redcorner, index: false
    add_reference :matches, :bluecorner, index: false
  end
end
