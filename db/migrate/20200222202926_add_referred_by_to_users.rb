class AddReferredByToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :referred_by, foreign_key: { to_table: :users }
  end
end
