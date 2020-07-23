require_relative 'requireable'

class AppTest
  INFO_PROC = proc { |a, b, c| puts "#{a} | #{b} | #{c}" }

  attr_reader :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def create_stations(n)
    n.times { |index| @stations << Station.new("test_station#{index + 1}") }
  end

  def create_trains(train_class, n)
    n.times { |index| @trains << train_class.new("test-#{train_class}#{index + 1}") }
  end

  def create_wagons(wagon_class, n)
    n.times { @wagons << wagon_class.new(rand(1..100)) }
  end

  def create_routes(n)
    n.times do
      shuffled_stations = stations.shuffle

      @routes << Route.new(shuffled_stations.first, shuffled_stations.last)
    end
  end

  def assign_routes
    trains.each { |train| train.route = routes.sample }
  end

  def hook_wagons(n)
    trains.each do |train|
      n.times { train.hook(wagons.sample) }
    end
  end

  def info
    Station.all.each do |station|
      puts "Station: #{station.name}"
      station_trains_info(station)
    end
  end

  private

  def station_trains_info(station)
    station.each_train do |train|
      INFO_PROC.call(train.number, train.type, train.wagons.size)
      train_wagons_info(train)
    end
  end

  def train_wagons_info(train)
    case train.type
    when "PassengerTrain"
      train.each_wagon { |wagon, index| INFO_PROC.call(index + 1, wagon.class, "#{wagon.occupied_seats} #{wagon.available_seats}") }
    when "CargoTrain"
      train.each_wagon { |wagon, index| INFO_PROC.call(index + 1, wagon.class, "#{wagon.filled_volume} #{wagon.available_volume}") }
    end
  end
end
