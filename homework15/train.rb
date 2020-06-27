class Train
  @@all_trains = []

  attr_reader :wagons, :speed, :type, :route, :number

  def self.find(number)
    @@all_trains.bsearch { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@all_trains << self
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
    current_station.accept_train(self)
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
    return if @wagons.include?(wagon)
    @wagons << wagon if speed.zero?
  end

  def unhook(wagon)
    @wagons.delete(wagon) if speed.zero?
  end

  private

  attr_reader :station_index
end
