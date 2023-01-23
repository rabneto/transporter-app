class AddRecipienteNameToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :recipiente_name, :string
  end
end
