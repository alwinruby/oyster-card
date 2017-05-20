class Journey

  MIN_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station

  def begin(entry_station)
    @in_journey = true
    @entry_station = entry_station
  end

  def in_journey?
    @in_journey
  end

  def finish(exit_station)
    @in_journey = false
    @exit_station = exit_station
    fare
  end

  def complete?
    !!@entry_station and !!@exit_station
  end

  def fare
    complete? ? MIN_FARE : PENALTY
  end

end
