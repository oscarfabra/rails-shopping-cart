class ErrorNotifier < ActionMailer::Base
  default from: "Depot App <depot@example.com>"

  # Sends an error message indicating attempt to access an invalid_cart.
  def invalid_cart(cart_id)
    @cart_id = cart_id

    mail to: Rails.application.secrets.admin_email, subject: 'Depot App Exception: Invalid Cart'
  end
end
