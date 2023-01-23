class RemoveTmFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :transport_mode_id
  end
end
