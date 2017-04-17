class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1.50

  attr_reader :balance, :status

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @status = :unused
  end

  def top_up(amount)
    fail 'can not exceed limit' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficuent funds" if balance < MINIMUM_BALANCE
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
  end

  def in_journey?
    @status == :in_use
  end

end
