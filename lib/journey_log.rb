class JourneyLog
  attr_reader :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journey = @journey_class.new
    @journeys = []
  end

  def in_journey?
    current_journey.in_journey?
  end

  def start(station)
    current_journey.begin(station)
  end

  def finish(station)
    @journeys << { "Entry Station:" => current_journey.entry_station, "Exit station:" => station }
    current_journey.finish(station)
  end

  private

  def current_journey
    @journey.complete? ? @journey = @journey_class.new : @journey
  end

end
