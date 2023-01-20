class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :min_range
      t.integer :max_range
      t.integer :hours
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
