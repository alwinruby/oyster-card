require 'journey'

describe Journey do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  subject(:journey) { described_class.new(entry_station) }

  describe '#start_journey' do
    it 'should be able to start a journey' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#end_journey' do
    it 'should be able to end the journey' do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end

    it 'should return entire journey' do
      expect(journey.finish(exit_station)).to eq journey
    end
  end

  describe '#fare' do
    it 'should return minimum fare' do
      journey.finish(exit_station)
      expect(journey.fare).to eq 1
    end

    it 'should return penalty fare' do
      expect(journey.fare).to eq 6
    end
  end
end
