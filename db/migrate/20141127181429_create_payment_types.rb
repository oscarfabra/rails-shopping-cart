class CreatePaymentTypes < ActiveRecord::Migration
  def up
    create_table :payment_types do |t|
      t.string :pay_name
      t.timestamps
    end

    PaymentType.create pay_name: "Check"
    PaymentType.create pay_name: "Credit card"
    PaymentType.create pay_name: "Purchase order"
  end

  def down
    drop_table :payment_types
  end
end
