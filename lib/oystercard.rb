class Oystercard

  attr_accessor :balance, :entry_station, :exit_station, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail 'Maximum balance of #{MAXIMUM_BALANCE} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if insufficient_balance?
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    self.exit_station = station
    self.journey_history << { entry: self.entry_station, exit: self.exit_station }
    self.entry_station = nil
  end

  private

  def insufficient_balance?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
