class AddLastnameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :lastname, :string, default: '',null: false
  end
end
