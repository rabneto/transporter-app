class CreateTransportModes < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_modes do |t|
      t.string :name
      t.integer :min_range
      t.integer :max_range
      t.integer :min_weight
      t.integer :max_weight
      t.integer :tax
      t.integer :active

      t.timestamps
    end
  end
end
