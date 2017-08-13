module PlansHelper
  def money(amount)
    Money.new(amount).format(symbol: true)
  end
end
