class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :clubs, :patch_types_id
  end
end
