class AddDocExpirationDatesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :drivers_license_expiration_date, :date
    add_column :users, :insurance_card_expiration_date, :date
  end
end
