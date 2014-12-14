require 'rest_client' # Using RestClient library.

class PaymentsProxyController < ApplicationController

  include CurrentPayment

  # POST /read_response
  # POST /read_response.json
  def read_response
    # TODO: Read response from payments gateway and send it to orders_controller.
  end
end
