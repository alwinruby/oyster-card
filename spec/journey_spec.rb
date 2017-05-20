require 'journey'

describe Journey do

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  it 'should be able to begin a journey' do
    expect{ subject.begin(entry_station) }.to change{ subject.in_journey? }.to true
  end

  it 'should be able to finish a journey' do
    expect{ subject.finish(exit_station) }.to change{ subject.in_journey? }.to false
  end

  it 'records the entry station' do
    subject.begin(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'records the exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  describe '#complete?' do
    it 'should be complete after beginning and finishing a journey' do
      subject.begin(entry_station)
      subject.finish(exit_station)
      expect(subject.complete?).to eq true
    end

    it 'should not be complete if an exit station is missing' do
      subject.begin(entry_station)
      expect(subject.complete?).to eq false
    end

    it 'should not be complete if an entry station is missing' do
      subject.finish(exit_station)
      expect(subject.complete?).to eq false
    end

    it 'should not be complete when both stations are missing' do
      expect(subject).to_not be_complete
    end
  end

  describe '#fare' do

    it 'should return a penalty of £6 if journey not completed' do
      allow(subject).to receive(:complete?).and_return(false)
      expect(subject.fare).to eq Journey::PENALTY
    end

    it 'should return correct fare if journey is completed' do
      allow(subject).to receive(:complete?).and_return(true)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
  end
end
