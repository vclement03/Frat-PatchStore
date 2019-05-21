class AddApprovalStatusToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :approval_status, :integer
  end
end
