class ChangeTitleColumnNameInProducts < ActiveRecord::Migration
  def change
    rename_column :products, :title, :name
  end
end
