RSpec.describe Train do
  let!(:train) { Train.new('A01') }
  let!(:wagon) { Wagon.new }
  let!(:wagon2) { Wagon.new }
  let!(:station1) { Station.new('Almaty') }
  let!(:station2) { Station.new('Astana') }
  let!(:station3) { Station.new 'Oskemen' }
  let!(:route) { Route.new(station1, station2) }

  describe '#wagons' do
    it 'returns wagons hooked to train' do
      train.hook(wagon)
      expect(train.wagons.include?(wagon)).to eq true
    end
  end

  describe '#speed' do
    it 'returns current speed' do
      expect(train.speed).to eq 0

      train.go

      expect(train.speed).to eq 10
    end
  end

  describe '#number' do
    it 'returns train number' do
      expect(train.number).to eq 'A01'
    end
  end

  describe '#route' do
    it 'returns train route' do
      train.route = route
      expect(train.route).to eq route
    end
  end

  describe '#go' do
    it 'increases speed by 10' do
      3.times { train.go }
      expect(train.speed).to eq 30
    end
  end

  describe '#stop' do
    it 'stops train' do
      3.times { train.go }
      train.stop
      expect(train.speed).to eq 0
    end
  end

  describe '#hook' do
    context 'when speed is zero' do
      it 'hooks the wagon' do
        train.hook(wagon)
        expect(train.wagons.include?(wagon)).to eq true
      end
    end

    context 'when speed > zero' do
      it 'returns nil' do
        train.go
        expect(train.hook(wagon)).to eq nil
      end
    end

    context 'when wagon is alreader hooked' do
      it 'returns nil' do
        train.hook(wagon)
        expect(train.hook(wagon)).to eq nil
      end
    end
  end

  describe '#unhook' do
    context 'when speed is zero'
    it 'unhooks wagon' do
      train.hook(wagon)
      train.unhook(wagon)
      expect(train.wagons.include?(wagon)).to eq false
    end

    context 'when speed more than 0'
    it 'returns nil' do
      train.hook(wagon)
      train.go
      expect(train.unhook(wagon)).to eq nil
      expect(train.wagons.include?(wagon)).to eq true
    end
  end

  describe '#each_wagon' do
    it 'yields each wagon hooked to train' do
      train.hook(wagon)
      train.hook(wagon2)

      wagons = []

      train.each_wagon { |wagon| wagons << wagon }

      expect(wagons).to eq train.wagons
    end
  end

  describe '#route=(route)' do
    it 'assigns route, sends train to first station' do
      train.route = route
      expect(train.route).to eq route
      expect(train.current_station).to eq route.stations[0]
    end
  end

  describe '#current_station' do
    it 'returns current station' do
      train.route = route
      expect(train.current_station).to eq route.stations[0]

      train.move_forward
      expect(train.current_station).to eq route.stations[1]
    end
  end

  describe '#next_station' do
    it 'returns next station' do
      train.route = route
      expect(train.next_station).to eq route.stations[1]
    end
  end

  describe '#previous_station' do
    it 'returns previous station' do
      train.route = route
      train.move_forward
      expect(train.previous_station).to eq route.stations[0]
    end
  end

  describe '#move_forward' do
    it 'moves train on next station' do
      train.route = route
      train.move_forward
      expect(station2.trains.include?(train)).to eq true
      expect(station1.trains.include?(train)).to eq false
    end
  end

  describe '#move_backward' do
    it 'moves train to previous station' do
      train.route = route
      train.move_forward
      train.move_backward
      expect(station1.trains.include?(train)).to eq true
      expect(station2.trains.include?(train)).to eq false
    end
  end

  describe '.all' do
    it 'returns all trains' do
      expect(Train.all.include?(train)).to eq true
    end
  end

  describe '.find' do
    it 'returns train by number' do
      train = Train.new('777')
      expect(Train.find('777')).to eq train
    end
  end
end
