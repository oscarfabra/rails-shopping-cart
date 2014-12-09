class AddTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal, precision: 8, scale: 2
  end
end
