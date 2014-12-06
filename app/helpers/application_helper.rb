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
end
