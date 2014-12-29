module ApplicationHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  # Converts the given amount to currency of the locale.
  def number_to_locale(amount)
    case I18n.locale.to_s
      when 'es'  # Converts to colombian pesos (COP)
        GoogCurrency.usd_to_cop(amount)
      when 'en'
        amount
    end
  end

  # Tells whether any kind of user is logged in.
  def user_logged_in?
    session[:customer_id]
  end

  # Tells whether an admin user is logged in.
  def admin_logged_in?
    return false unless session[:customer_id]

    admin = Admin.find_by(customer_id: session[:customer_id])
    admin
  end

  # Tells whether given customer is admin.
  def is_admin?(customer_id)
    admin = Admin.find_by(customer_id: customer_id)
    admin
  end
end
