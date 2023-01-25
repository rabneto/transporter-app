class ChangeKmPriceToBeNumericInPrices < ActiveRecord::Migration[7.0]
  def change
    change_column :prices, :km_price, :numeric, precision: 5, scale: 2
  end
end
