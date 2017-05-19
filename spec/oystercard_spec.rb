require 'oystercard'

describe Oystercard do

  let(:entry_station){ double :station }
  let(:exit_station){ double :station }

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
  end

  it 'can top up the balance' do
    expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
  end

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{MAXIMUM_BALANCE} exceeded'
  end


  it "can touch in" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it "can touch out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to eq nil
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
  end

  it 'deducts fare on touch out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by -1
  end

  it "stores exit station" do
  	subject.top_up(1)
  	subject.touch_in(entry_station)
  	subject.touch_out(exit_station)
  	expect(subject.exit_station).to eq exit_station
  end

  it "records this journey in history" do
  	subject.top_up(10)
  	subject.touch_in(entry_station)
  	subject.touch_out(exit_station)
  	journey = {entry: entry_station, exit: exit_station}
  	expect(subject.journey_history).to include journey
	end

  describe '#journey history' do
    it {is_expected.to respond_to(:journey_history)}
  end

end
