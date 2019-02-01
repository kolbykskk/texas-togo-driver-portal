class CreatePaymentSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_sheets do |t|
      t.string :sheet

      t.timestamps
    end
  end
end
