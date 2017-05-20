require 'oystercard'

describe Oystercard do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  it 'new oystercard has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it "should increase the balance by top up amount" do
    expect{subject.top_up(10)}.to change{subject.balance}.by(+10)
  end

  it 'should throw an excption if balance exceeds 90' do
    maximum = Oystercard::MAX_BALANCE
    expect{ subject.top_up(maximum+1) }.to raise_error 'Maximum amount exceeded'
  end

  it 'is not in a journey to start with' do
    expect(subject).not_to be_in_journey
  end

  context '#touch_in' do

    it 'touch in changes the state of the journey' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'raises an error when insufficient balance' do
      expect {subject.touch_in(entry_station)}.to raise_error "Sorry, insufficient funds"
    end

  end

  context '#touch_out' do

    it 'deducts money from balance when touching_out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end

  end

  context '#journeys' do
    it 'it has ability to stores journeys' do
      expect(subject.journeys).to be_empty
    end

    it 'it has the ability to create a journey by touching in and out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      journey = [{ "Entry Station:" => entry_station, "Exit station:" => exit_station }]
      expect(subject.journeys).to eq journey
    end
  end

end
