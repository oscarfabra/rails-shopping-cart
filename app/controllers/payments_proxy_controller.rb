require 'rest_client' # Using RestClient library.

class PaymentsProxyController < ApplicationController

  include CurrentPayment

  # POST /read_response
  # POST /read_response.json
  def read_response
    # TODO: Read response from payments gateway and send it to orders_controller.
    logger.info "Received data: #{params}"
    # logger.info "payments_server hash: #{params[:payments_server]}"

    # Creates a new order for later retrieval.
    # order = Order.new(order_reader_params)

    notice = (params[response_code] == 'SUCCESS')?
        'Payment was successfully made.' : "Payment couldn't be made."

    respond_to do |format|
      format.html { redirect_to '/', notice: notice }
      format.json do  # render an html page instead of a JSON response.
        redirect_to '/', notice: notice
      end
    end
  end
end
