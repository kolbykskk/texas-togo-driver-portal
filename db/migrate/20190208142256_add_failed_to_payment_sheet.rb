class AddFailedToPaymentSheet < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_sheets, :failed, :boolean
  end
end
