class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :club_id
      t.integer :order_id
      t.string :value

      t.timestamps
    end
  end
end
