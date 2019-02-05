class CreateDisbursments < ActiveRecord::Migration[5.0]
  def change
    create_table :disbursments do |t|
      t.references :payment_sheet, foreign_key: true
      t.string :driver_name
      t.string :driver_phone
      t.integer :amount

      t.timestamps
    end
  end
end
