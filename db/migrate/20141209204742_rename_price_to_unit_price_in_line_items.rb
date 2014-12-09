class RenamePriceToUnitPriceInLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :price, :unit_price
  end
end
