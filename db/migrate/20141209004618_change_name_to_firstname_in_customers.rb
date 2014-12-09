class ChangeNameToFirstnameInCustomers < ActiveRecord::Migration
  def change
    rename_column :customers, :name, :firstname
  end
end
