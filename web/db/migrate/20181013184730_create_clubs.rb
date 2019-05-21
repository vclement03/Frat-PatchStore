class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :value_type
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
