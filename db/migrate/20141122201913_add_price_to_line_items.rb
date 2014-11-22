class AddPriceToLineItems < ActiveRecord::Migration

  def up
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2

    # Walks through each line_item adding the product's price
    LineItem.all.each do |line_item|
      line_item.update_attribute :price, line_item.product.price
    end
  end

  def down
    # Remove price column from line_items
    remove_column :line_items, :price
  end

end
