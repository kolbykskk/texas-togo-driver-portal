class RemoveNotFoundFromPaymentSheet < ActiveRecord::Migration[5.0]
  def change
    remove_column :payment_sheets, :not_found
  end
end
