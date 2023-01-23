class ChangeProductIdToBeStringInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :product_id, :string
  end
end
