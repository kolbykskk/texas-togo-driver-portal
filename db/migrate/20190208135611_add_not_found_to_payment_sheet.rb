class AddNotFoundToPaymentSheet < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_sheets, :not_found, :integer
  end
end
