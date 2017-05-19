class Oystercard

  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Maximum balance of #{MAXIMUM_BALANCE} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient balance to touch in" if insufficient_balance?
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
  	@in_journey = false
  end

  private

  def insufficient_balance?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
