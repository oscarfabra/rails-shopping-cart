class AddOrderNoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_no, :string, default: '',null: false
  end
end
