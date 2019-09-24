class AddForeignKeyPatchTypeToClubs < ActiveRecord::Migration[5.2]
  def change
    add_reference :clubs, :patch_types, foreign_key: true
  end
end
