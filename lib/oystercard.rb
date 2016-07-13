class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_accessor :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    self.balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    fail "Not enough balance" if balance < MIN_BALANCE
    self.entry_station = station
  end

  def touch_out
    deduct(MIN_BALANCE)
    self.entry_station = nil
  end

private

  def deduct(amount)
    self.balance -= amount
  end

end
