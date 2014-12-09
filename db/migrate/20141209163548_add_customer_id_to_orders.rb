class AddCustomerIdToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :customer, default: 1, null: false, index: true
  end
end
