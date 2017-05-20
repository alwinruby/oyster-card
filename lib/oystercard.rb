require 'journey'
require 'journey_log'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey_log.in_journey?
  end

  def touch_in(station)
    fail "Sorry, insufficient funds" if balance < MIN_BALANCE
    @journey_log.start(station)
  end

  def touch_out(station)
    deduct(@journey_log.finish(station))
  end

  def journeys
    @journey_log.journeys.dup
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
