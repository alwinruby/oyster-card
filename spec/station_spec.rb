require 'station'

describe Station do

  subject { described_class.new(name: 'cereal', zone: 89) }

  it 'should return a station name' do
    expect(subject.name).to eq 'cereal'
  end

  it 'should return a station zone' do
    expect(subject.zone).to eq 89
  end

end
