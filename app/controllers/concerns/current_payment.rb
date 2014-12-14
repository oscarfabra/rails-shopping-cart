require 'rest_client' # Using RestClient library.

module CurrentPayment
  extend ActiveSupport::Concern

  private

    def make_payment(order_params, format)
      # Sets content to send.
      content = nil
      case format
        when :json
          content = order_params.to_json
      end
      # Makes a post request with the content and reads redirect_url.
      redirect_url = ''
      RestClient.post(Rails.application.secrets.payments_gateway_read_order_url,
                      content,
                      :content_type => format,
                      :accept => format) do |response, request, result, &block|
        if [301, 302, 307].include? response.code
          redirect_url = response.headers[:location]
          logger.info "#{redirect_url} Response: #{response}"
          logger.info "Following redirection..."
          response.follow_redirection(request, result, &block)
        else
          logger.info "Response: #{response}"
          logger.info "Returning..."
          response.return!(request, result, &block)
        end
      end
      # Returns redirect_url.
      redirect_url
    end

    def read_response(gateway_response)
      # TODO: Write code to return answer to orders_controller.
    end
end