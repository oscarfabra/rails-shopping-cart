json.extract! @order, :order_no, :customer_id, :address, @order.customer.email,
              :total, :pay_type, :created_at, :updated_at
