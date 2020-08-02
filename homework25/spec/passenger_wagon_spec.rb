RSpec.describe PassengerWagon do
  subject { PassengerWagon.new(10) }

  describe '#seats' do
    it "returns amount of seats" do
      expect(subject.seats).to eq 10
    end
  end

  describe '#occupied_seats' do
    it 'returns amount of occupied seats' do
      3.times { subject.occupy_seat }
      expect(subject.occupied_seats).to eq 3
    end
  end

  describe '#available_seats' do
    it 'returns amount of available seats' do
      3.times { subject.occupy_seat }
      expect(subject.available_seats).to eq 7
    end
  end

  describe '#occupy_seat' do
    context 'when there are available seats' do
      it 'occupies one seat per call' do
        3.times { subject.occupy_seat }
        expect(subject.occupied_seats).to eq 3
      end
    end

    context 'when no available seats' do
      it 'returns nil' do
        10.times { subject.occupy_seat }
        expect(subject.occupy_seat).to eq nil
      end
    end
  end
end
