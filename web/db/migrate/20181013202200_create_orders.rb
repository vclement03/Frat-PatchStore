class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :transaction_id
      t.string :email
      t.integer :status
      t.string :token
      t.string :full_name

      t.timestamps
    end
  end
end
