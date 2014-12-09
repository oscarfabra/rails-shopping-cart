module OrdersHelper
  # Tells whether order has been shipped or is pending.
  def display_status(order)
    if !order.ship_date
      "Pending"
    else
      "Shipped"
    end
  end
end
