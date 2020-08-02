RSpec.describe CargoWagon do
  subject { CargoWagon.new(100) }

  describe '#volume' do
    it "returns vagon's volume" do
      expect(subject.volume).to eq 100
    end
  end

  describe '#available_volume' do
    it 'returns available volume' do
      expect(subject.available_volume).to eq 100
    end
  end

  describe '#filled_volume' do
    it 'returns filled volume' do
      expect(subject.filled_volume).to eq 0
    end
  end

  describe '#fill_volume' do
    context 'with valid params' do
      it "fills wagon's volume" do
        subject.fill_volume(90)
        expect(subject.filled_volume).to eq 90
        expect(subject.available_volume).to eq 10
      end
    end

    context 'with invalid params' do
      it 'returns nil' do
        expect(subject.fill_volume(500)).to eq nil
        expect(subject.filled_volume).to eq 0
      end
    end
  end
end
