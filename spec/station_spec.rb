require 'station'

describe Station do
  subject(:station){described_class.new('bank', 1)}

  context "on creation" do

    it "has a name" do
      expect(station.name).to eq 'bank'
    end

    it "is in a zone" do
      expect(station.zone).to eq 1
    end

  end

end
