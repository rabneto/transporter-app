class UpdateActiveOnProductModes < ActiveRecord::Migration[7.0]
  def change
    change_column :transport_modes, :active, :integer, default: 1
  end
end
