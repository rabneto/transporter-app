class UpdateStatusOnCategories < ActiveRecord::Migration[7.0]
  def change
    change_column :categories, :status, :integer, default: 1
  end
end
