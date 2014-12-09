class RemoveNameFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :name
  end
end
