module CurrentOrder
  extend ActiveSupport::Concern

  private

    def get_order_no
      # Can add more complexity as required.
      # TODO: Avoid concurrency issues, if users create orders at same time.
      last_order = Order.last
      if last_order
        "O#{last_order.id + 1}"
      else
        "O#{1}"
      end
    end

    def set_customer_details(order)
      order.customer_id = session[:customer_id]
      order.customer = Customer.find_by(id: order.customer_id)
      # order.email =
    end
end