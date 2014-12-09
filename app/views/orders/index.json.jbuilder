json.array!(@orders) do |order|
  json.extract! order, :id, :customer_id, :address, :email, :pay_type
  json.url order_url(order, format: :json)
end
