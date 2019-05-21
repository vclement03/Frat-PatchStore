class CreateJoinTableClubPatchType < ActiveRecord::Migration[5.2]
  def change
    create_join_table :clubs, :patch_types do |t|
      t.index [:club_id, :patch_type_id]
      t.index [:patch_type_id, :club_id]
    end
  end
end
