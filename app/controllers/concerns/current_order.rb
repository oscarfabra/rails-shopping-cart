module CurrentOrder
  extend ActiveSupport::Concern

  private

    def set_order_no
      # Can add more complexity as required.
      # TODO: Avoid concurrency issues, if users create orders at same time.
      last_order = Order.last
      if last_order
        "O#{last_order.id + 1}"
      else
        "O#{1}"
      end
    end
end