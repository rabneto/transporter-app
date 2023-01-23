class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.datetime :start
      t.datetime :deadline
      t.datetime :delivered
      t.string :delay_reason
      t.integer :distance
      t.integer :product_id
      t.integer :product_width
      t.integer :product_height
      t.integer :product_depth
      t.integer :product_weight
      t.string :origin_address
      t.string :origin_city
      t.string :origin_uf
      t.string :destiny_address
      t.string :destiny_city
      t.string :destiny_uf
      t.string :recipient_document
      t.string :recipient_email
      t.string :recipient_phone
      t.integer :status
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
