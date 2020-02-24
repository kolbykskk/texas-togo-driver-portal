class AddReferPaidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :refer_paid, :boolean
  end
end
