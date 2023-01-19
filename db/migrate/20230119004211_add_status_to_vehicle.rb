class AddStatusToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :status, :integer, default: 1
  end
end
