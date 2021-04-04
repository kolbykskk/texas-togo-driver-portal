class AddDiscoveredToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :discovered, :string
  end
end
