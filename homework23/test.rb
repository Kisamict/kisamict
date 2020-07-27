require_relative 'requireable'

class AppTest
  def self.info
    Station.all.each do |station|
      puts "Station: #{station.name}"
      station.trains.each do |train|
        puts "Train: #{train.number} | #{train.class} | #{train.wagons.size}"
        train.wagons.each_with_index do |wagon, index|
          puts "Wagon: #{index + 1} | #{wagon.available_seats} | #{wagon.occupied_seats}" if wagon.is_a?(PassengerWagon)
          puts "Wagon: #{index + 1} | #{wagon.available_volume} | #{wagon.filled_volume}" if wagon.is_a?(CargoWagon)
        end
      end
    end
  end

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
end
