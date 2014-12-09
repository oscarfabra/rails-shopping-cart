module CurrentUser
  extend ActiveSupport::Concern

  private

    # Tells whether any kind of user is logged in.
    def user_logged_in
      session[:customer_id]
    end

    # Tells whether user logged in is an admin.
    def admin_logged_in
      return false unless session[:customer_id]

      admin = Admin.find_by(customer_id: session[:customer_id])
      admin
    end
end