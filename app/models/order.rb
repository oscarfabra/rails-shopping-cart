class Order < ActiveRecord::Base
  # Constant array shown to user as a drop-down list.
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
end
