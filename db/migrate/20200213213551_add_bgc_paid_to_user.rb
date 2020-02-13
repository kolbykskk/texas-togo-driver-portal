class AddBgcPaidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bgc_paid, :boolean
  end
end
