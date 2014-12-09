class AddTotalPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :total_price, :decimal, precision: 8, scale: 2
  end
end
