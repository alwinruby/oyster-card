class Journey

  attr_reader :entry_station, :exit_station

  FARE = 1
  PENALTY = 6

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def finish(station)
    @exit_station = station
    self
  end

  def complete_journey
    { entry: self.entry_station, exit: self.exit_station }
  end

  def fare
    return PENALTY if entry_station == nil || exit_station == nil
    FARE
  end

end
