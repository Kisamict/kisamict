class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.find_all{ |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    return if end_station?(station)
    @stations.delete(station)
  end

  private

  def end_station?(station)
    station == @stations.first || station == @stations.last
  end
end

class Train
  attr_reader :wagons, :speed, :type, :route

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      next_station.accept_train(self)
      @station_index += 1
    end
  end

  def move_backward
    if previous_station
      current_station.send_train(self)
      previous_station.accept_train(self)
      @station_index -= 1
    end
  end

  def route=(route)
    @route = route
    @station_index = 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def go
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def hook(wagon)
    @wagons << wagon if speed.zero?
  end

  def unhook(wagon)
    @wagons.delete(wagon) if speed.zero?
  end

  private

  attr_reader :station_index
end

class CargoTrain < Train
  def initialize(number)
    super
    @type = "CargoTrain"
  end

  def hook(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end

class PassengerTrain < Train
  def initialize(number)
    super
    @type = "PassengerTrain"
  end

  def hook(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end

class Wagon
end

class CargoWagon < Wagon
  def initialize(volume)
    @volume = volume
  end
end

class PassengerWagon < Wagon
  def initialize(seats)
    @seats = seats
  end
end
