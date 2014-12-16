require 'rest_client' # Using RestClient library.

class PaymentsProxyController < ApplicationController

  include CurrentPayment

  # POST /read_response
  # POST /read_response.json
  def read_response
    # TODO: Read response from payments gateway and send it to orders_controller.
    logger.info "Received data: #{params}"
    #logger.info "notice hash: #{params[:payments_proxy]}"

    redirect_to '/'

    <<-DOC
    respond_to do |format|
      if order.save!
        session[:order_id] = order.id
        format.html { redirect_to '/payments/new.html' }
        format.json do  # render an html page instead of a JSON response.
          redirect_to '/payments/new.html'
        end
      else
        format.html { redirect_to '/payments/new.html' }
        format.json { render json: params, status: :unprocessable_entity }
      end
    end
    DOC
  end
end
