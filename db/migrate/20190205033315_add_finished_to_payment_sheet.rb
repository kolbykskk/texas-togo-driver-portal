class AddFinishedToPaymentSheet < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_sheets, :finished, :boolean, default: false
  end
end
