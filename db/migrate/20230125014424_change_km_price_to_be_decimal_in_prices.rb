class ChangeKmPriceToBeDecimalInPrices < ActiveRecord::Migration[7.0]
  def change
    change_column :prices, :km_price, :decimal, precision: 15, scale: 2
  end
end
