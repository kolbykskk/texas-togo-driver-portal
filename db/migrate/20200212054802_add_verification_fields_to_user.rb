class AddVerificationFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :drivers_license, :string
    add_column :users, :insurance_card, :string
  end
end
