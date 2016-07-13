class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_accessor :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    self.balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Not enough balance" if balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
  end

private

  def deduct(amount)
    self.balance -= amount
  end

end
