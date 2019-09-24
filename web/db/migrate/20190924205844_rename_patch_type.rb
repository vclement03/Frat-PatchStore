class RenamePatchType < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :clubs, :patch_types
  end
end
