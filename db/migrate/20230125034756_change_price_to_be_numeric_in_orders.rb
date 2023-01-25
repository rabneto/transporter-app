class ChangePriceToBeNumericInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :price, :numeric, precision: 5, scale: 2
  end
end
