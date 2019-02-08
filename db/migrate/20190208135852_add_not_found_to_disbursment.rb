class AddNotFoundToDisbursment < ActiveRecord::Migration[5.0]
  def change
    add_column :disbursments, :not_found, :boolean
  end
end
