class AddEmailToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :email, :string, default: 'user@example.com',
               null: false, index: true
  end
end
