class AddPayTypeToOrder < ActiveRecord::Migration
  def up
    add_reference :orders, :payment_type, index: true

    # Walks through each order adding the corresponding payment_type value.
    Order.all.each do |order|
      pay_type = PaymentType.find_by(pay_type: order.pay_type)
      order.update_attribute :payment_type_id, pay_type.id
    end
  end

  def down
    # Remove payment_type_id column from orders
    remove_column :orders, :payment_type_id
  end
end
