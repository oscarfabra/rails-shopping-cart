class RemoveEmailFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :email
  end
end
