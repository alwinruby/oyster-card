class Station

  attr_reader :stations, :zone, :name

  def initialize(args)
    @stations = ['station1', 'station2', 'station3' ]
    @name = args[:name]
    @zone = args[:zone]
  end
end
