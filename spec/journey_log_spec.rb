require 'journey_log'
require 'journey'

describe JourneyLog do
  subject { JourneyLog.new(Journey) }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  it 'should start a journey with an entry_station' do
    expect{ subject.start(entry_station) }.to change{ subject.in_journey? }.to true
  end

  it 'should end a journey with an exit_station' do
    expect{ subject.finish(exit_station) }.to change{ subject.in_journey? }.to false
  end

  it 'returns a list of journeys' do
    expect(subject.journeys).to be_empty
  end

end
