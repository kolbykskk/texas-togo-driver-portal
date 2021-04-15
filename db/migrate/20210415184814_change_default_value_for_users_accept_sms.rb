class ChangeDefaultValueForUsersAcceptSms < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :accept_sms, false
  end
end
