class AddDefaultValueToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role, :string, :default => "member"
  end
end
