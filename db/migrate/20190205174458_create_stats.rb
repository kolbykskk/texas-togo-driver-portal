class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :deliveries
      t.integer :days_worked
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
