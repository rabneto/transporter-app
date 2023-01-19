class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand
      t.string :model
      t.integer :year
      t.integer :max_weight
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
