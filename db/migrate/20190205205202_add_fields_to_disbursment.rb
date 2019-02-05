class AddFieldsToDisbursment < ActiveRecord::Migration[5.0]
  def change
    add_column :disbursments, :commissions, :integer
    add_column :disbursments, :tips, :integer
    add_column :disbursments, :charges, :integer
    add_column :disbursments, :credits, :integer
    add_column :disbursments, :deliveries_made, :integer
  end
end
