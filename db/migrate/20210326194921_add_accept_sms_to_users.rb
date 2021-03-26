class AddAcceptSmsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :accept_sms, :boolean
  end
end
