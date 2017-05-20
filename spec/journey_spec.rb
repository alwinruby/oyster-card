require 'journey'

describe Journey do
  let(:station) { double('station', :zone => 2) }
  subject(:trip) { described_class.new(station)}
  let(:station2) { double('station2', :zone => 6) }

  context "when touched in" do

    it "accept the touch in station" do
      expect(trip.journey[:entry]).to eq station
    end

    it "knows a journey is incomplete" do
      expect(trip.journey_complete?).to be false
    end
  end

  context "when touched out" do

    before (:example) do
      subject.end_journey(station)
    end

    it "remembers the touch out station" do
      expect(subject.journey[:exit]).to eq station
    end

    it "knows when a journey is complete" do
      expect(trip.journey_complete?).to be true
    end

    it "calculates a minimum fare when journey is complete" do
      expect(trip.fare).to eq Journey::MINIMUM_FARE
    end

  end

  context "calculates" do

    it "a penalty fare when journey is incomplete" do
      expect(trip.fare).to eq Journey::PENALTY_FARE
    end

    it "calculates the fare between two journey zones" do
      trip.end_journey(station2)
      expect(trip.fare).to eq 5
    end

  end
end
