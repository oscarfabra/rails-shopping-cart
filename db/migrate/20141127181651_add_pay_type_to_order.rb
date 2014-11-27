class AddPayTypeToOrder < ActiveRecord::Migration
  def up
    add_reference :orders, :payment_type, index: true

    # Walks through each order adding the corresponding payment_type value.
    Order.all.each do |order|
      pay_type_id = 0
      case order.pay_type
      when 'Check'
        pay_type_id = 1
      when 'Credit card'
        pay_type_id = 2
      when 'Purchase order'
        pay_type_id = 3
      end
      order.update_attribute(:payment_type_id, pay_type_id)
    end
  end

  def down
    # Remove payment_type_id column from orders
    remove_column :orders, :payment_type_id
  end
end
