RSpec.describe Route do
  let!(:station1) { Station.new('Almaty') }
  let!(:station2) { Station.new('Astana') }
  let!(:station3) { Station.new('Quapshagai') }
  subject { Route.new(station1, station2) }

  describe '#name' do
    it "returns route's name" do
      expect(subject.name).to eq 'Almaty-Astana'
    end
  end

  describe '#stations' do
    it "returns route's stations" do
      expect(subject.stations).to eq [station1, station2]
    end
  end

  describe '#add' do
    it "adds station in the middle of route" do
      subject.add(station3)
      expect(subject.stations[1]).to eq station3
    end

    context 'if route already includes station' do
      it "returns nil" do
        expect(subject.add(station1)).to eq nil
      end
    end
  end

  describe '#remove' do
    it "removes station from route" do
      subject.add(station3)
      subject.remove(station3)
      expect(subject.stations.include?(station3)).to eq false
    end

    context 'if station is first or last' do
      it 'returns nil' do
        expect(subject.remove(station1)).to eq nil
      end
    end
  end

  describe '.all' do
    it "returns hash where key is route name and value is it stations" do
      expect(Route.all.include?(subject)).to eq true
    end
  end
end
