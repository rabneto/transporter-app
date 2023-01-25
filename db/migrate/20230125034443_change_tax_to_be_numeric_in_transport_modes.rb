class ChangeTaxToBeNumericInTransportModes < ActiveRecord::Migration[7.0]
  def change
    change_column :transport_modes, :tax, :numeric, precision: 5, scale: 2
  end
end
