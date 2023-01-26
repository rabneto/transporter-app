class AddTaxKmPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :tax, :numeric, precision: 5, scale: 2
    add_column :orders, :km_price, :numeric, precision: 5, scale: 2
  end
end
