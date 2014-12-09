ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Login the appropriate customer for all tests.
  def login_as(customer)
    session[:customer_id] = customers(customer).id
  end

  def logout
    session.delete :customer_id
  end

  def setup
    login_as :one if defined? session
  end
end
