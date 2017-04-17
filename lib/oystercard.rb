class Oystercard

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail 'can not exceed limit' if balance + amount > MAX_LIMIT
    @balance += amount
  end

end
