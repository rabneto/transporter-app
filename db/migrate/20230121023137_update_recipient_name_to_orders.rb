class UpdateRecipientNameToOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :recipiente_name, :recipient_name
  end
end
