module ApplicationHelper
  def format_currency(amount, currency)
    case currency
    when 'RUB'
      "#{number_to_currency(amount, unit: '₽', format: '%n %u')}"
    when 'EUR'
      "#{number_to_currency(amount, unit: '€', format: '%n %u')}"
    when 'GBP'
      "#{number_to_currency(amount, unit: '£', format: '%n %u')}"
    else
      "#{number_to_currency(amount, unit: '$', format: '%n %u')}"
    end
  end
end
