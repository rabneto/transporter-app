class UpdateStatusOnOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :status, :integer, default: 1
  end
end
