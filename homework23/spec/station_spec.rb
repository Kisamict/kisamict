RSpec.describe Station do
  let!(:station) { Station.new('Almaty') }
  let!(:cargo_train1) { CargoTrain.new(100) }
  let!(:cargo_train2) { CargoTrain.new(80) }
  let!(:passenger_train1) { PassengerTrain.new(100) }
  let!(:passenger_train2) { PassengerTrain.new(80) }

  describe '#name' do
    it "returns station name" do
      expect(station.name).to eq 'Almaty'
    end
  end

  describe '#trains' do
    it "returns all trains on station" do
      station.accept_train(cargo_train1)
      station.accept_train(passenger_train1)

      expect(station.trains).to eq [cargo_train1, passenger_train1]
    end
  end

  describe '#each_train' do
    it 'yields each train on station' do
      trains = []
      station.each_train { |train| trains << train }

      expect(trains).to eq station.trains
    end
  end

  describe '#accept_train' do
    let!(:train) { Train.new("A05") }

    it 'adds trains on station' do
      station.accept_train(train)

      expect(station.trains.include?(train)).to eq true
    end
  end

  describe '#send_train' do
    let!(:train) { Train.new("A05") }

    it 'deletes train from station' do
      station.accept_train(train)

      station.send_train(train)

      expect(station.trains.include?(train)).to eq (false)
    end
  end

  describe '#trains_by_type' do
    types = [PassengerTrain, CargoTrain]

    it 'returns all trains by type' do
      station.accept_train(cargo_train1)
      station.accept_train(cargo_train2)

      station.accept_train(passenger_train1)
      station.accept_train(passenger_train2)

      type = types.sample

      expect(station.trains_by_type(type)).to all (be_an(type))
    end
  end

  describe '.all' do
    it 'returns all stations' do
      expect(Station.all.include?(station)).to eq true
    end
  end
end
