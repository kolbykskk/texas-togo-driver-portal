class AddPayoutWaitToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :payout_wait, :datetime
  end
end
