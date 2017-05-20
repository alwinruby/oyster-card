require "oystercard"

describe Oystercard do
  subject(:card){ described_class.new }
  let(:station) { double(:station, :zone => 4) }
  let(:journey) { double(:journey) }

  context "new card " do

    it "has default balance zero" do
      expect(card.balance).to eq 0
    end

    it "has an empty journey history" do
      expect(card.journey_history).to be_empty
    end
  end

  context "changing balance" do

    it "tops up balance" do
      expect{card.top_up(5)}.to change{card.balance}.by(5)
    end

    it "raises error if over max. balance" do
      maximum_balance = Oystercard::LIMIT
      card.top_up(maximum_balance)
      message = "card limit #{maximum_balance} exceeded"
      expect{card.top_up(1)}.to raise_error message
    end
  end

  context "when touching in" do

    it "raises an error if a card with insufficient balance is touched in" do
      # card.top_up (Journey::MINIMUM_FARE - 1)
      message = "Insufficient balance. Minimum £#{Journey::MINIMUM_FARE} is required"
      expect{card.touch_in(station)}.to raise_error message
    end

    it 'deducts a penalty fare if forgot to touch_out first' do
      card.top_up(Journey::MINIMUM_FARE)
      card.touch_in(station)
      expect{ card.touch_in(station) }.to change{ card.balance }.by (-Journey::PENALTY_FARE)
    end

    it 'does not charge a penalty fare after a journey has been completed and user taps in again' do
      card.top_up(Oystercard::LIMIT)
      card.touch_in(station)
      card.touch_out(station)
      expect{ card.touch_in(station) }.to_not change{ card.balance }
    end
  end

  context "when touching out" do

    it "deducts the minimum fare for a journey on touch out" do
      card.top_up(Journey::MINIMUM_FARE)
      card.touch_in(station)
      expect{card.touch_out(station)}.to change {card.balance}.by (-Journey::MINIMUM_FARE)
    end
  end

  describe "recording journey history" do

    before (:each) do
      card.top_up(Journey::MINIMUM_FARE)
      card.touch_in(station)
      card.touch_out(station)
    end

    it "stores a list of journeys" do
      expect(card.journey_history.length).to eq 1
    end
  end
end 
