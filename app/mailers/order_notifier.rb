class OrderNotifier < ActionMailer::Base
  default from: "Depot App <depot@example.com>"

  # Creates an email confirming that order has been received.
  def received(order)
    @order = order

    mail to: order.customer.email, subject: "Depot App Order Confirmation"
  end

  # Creates an email confirming that order has been shipped.
  def shipped(order)
    @order = order

    mail to: order.customer.email, subject: "Depot App Order Shipped"
  end
end
