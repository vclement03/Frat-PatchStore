class AddPatchTypeIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :patch_type_id, :integer
  end
end
