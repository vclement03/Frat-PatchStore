class AddPatchTypeToClubs < ActiveRecord::Migration[5.2]
  def change
    add_reference :clubs, :patch_type, foreign_key: true
  end
end
