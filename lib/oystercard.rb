class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1.50

  attr_reader :balance, :trips, :list_of_journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @trips = {}
    @list_of_journeys = []
  end

  def top_up(amount)
    raise 'can not exceed limit' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds' if balance < MINIMUM_BALANCE
    @trips[:exit_station] = nil
    @trips[:entry_station] = station
  end

  def touch_out(station)
    @trips[:exit_station] = station
    deduct(MINIMUM_BALANCE)
    @list_of_journeys << [ trips[:entry_station], trips[:exit_station] ]
    @trips[:entry_station] = nil
  end

  def in_journey?
    @trips[:entry_station] != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
