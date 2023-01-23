class AddSenderToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :sender_name, :string
    add_column :orders, :sender_document, :string
    add_column :orders, :sender_phone, :string
    add_column :orders, :sender_email, :string
  end
end
