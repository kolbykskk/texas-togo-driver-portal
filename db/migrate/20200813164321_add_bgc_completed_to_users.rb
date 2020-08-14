class AddBgcCompletedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bgc_completed, :date
  end
end
