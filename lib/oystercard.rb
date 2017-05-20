require 'journey'

class Oystercard

  attr_accessor :balance, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey
  end

  def top_up(amount)
    raise 'Maximum balance exceeded' if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station = nil)
    raise 'Balance below minimum fare' if balance < MINIMUM_CHARGE
    start_journey(station)
  end

  def touch_out(station = nil)
    deduct(@journey.fare)
    end_journey(station)
    complete_journey
  end

  private

  def start_journey(entry_station)
    @journey = Journey.new(entry_station)
  end

  def end_journey(exit_station)
    @journey.finish(exit_station)
  end

  def complete_journey
    journeys << @journey.complete_journey
  end

  def insufficient_balance?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
