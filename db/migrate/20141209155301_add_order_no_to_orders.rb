class AddOrderNoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_no, :string, default: 'O0000001', null: false
  end
end
