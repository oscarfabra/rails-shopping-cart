# Loads 100 orders into the database, for testing purposes.
Order.transaction do
  (1..100).each do |i|
    Order.create(email: "customer-#{i}@example.com",
                 address: "#{i} Main Street",
                 order_no: "O#{i}",
                 customer_id: "#{i}",
                 pay_type: "Credit card",
                 payment_type_id: 2)
  end
end