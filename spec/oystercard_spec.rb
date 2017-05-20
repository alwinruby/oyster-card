require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe 'when new, the card' do
    it 'journey history should be empty' do
      expect(subject.journeys).to be_empty
    end

    it 'balance should have default value of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe 'top_up' do
    it 'should add money to balance' do
      expect { subject.top_up(5) }.to change { subject.balance }.by 5
    end
  end

  it 'should throw an error if balance would exceed the maximum limit' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    max_exceeded = maximum_balance + 1
    expect { subject.top_up(max_exceeded) }.to raise_error "Maximum balance exceeded"
  end

  context 'when touching in and out' do
    describe 'it checks balance' do
      it 'raises an error if it has less than the minimum balance' do
        min_fare = 'Balance below minimum fare'
        expect { subject.touch_in(entry_station) }.to raise_error min_fare
      end
    end

    describe 'at touch_out' do
      before(:each) do
        subject.top_up(2)
        subject.touch_in(entry_station)
      end

      it 'should deduct the minimum fare from the balance' do
        minimum = subject.journey.fare
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-minimum)
      end

      it 'should deduct the penalty fare from the balance' do
        penalty = subject.journey.fare
        expect { subject.touch_out }. to change { subject.balance }.by(-penalty)
      end

      before(:each) do
        subject.touch_out(exit_station)
      end

      let(:journey) { { entry: entry_station, exit: exit_station } }
      it 'stores a list of journeys' do
        expect(subject.journeys).to include journey
      end

    end

  end
end
