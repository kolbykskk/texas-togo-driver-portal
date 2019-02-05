class AddAttributesToPaymentSheet < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_sheets, :number_of_drivers, :integer
    add_column :payment_sheets, :total_paid, :integer
    add_column :payment_sheets, :not_found, :integer
  end
end
