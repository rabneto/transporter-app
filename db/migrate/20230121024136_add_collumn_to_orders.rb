class AddCollumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :transport_mode_id, :integer
  end
end
