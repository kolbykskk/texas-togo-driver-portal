class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
