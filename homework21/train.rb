class Train
  @@all = []

  def self.find(number)
    @@all.find { |train| train.number == number }
  end

  attr_reader :wagons, :speed, :type, :route, :number

  def each_wagon(&block)
    wagons.each_with_index { |wagon, idx| yield(wagon, idx) }
  end

  def initialize(number)
    @number = number
    validate
    @speed = 0
    @wagons = []
    @@all << self
  end

  def validate
    raise "Train number must be a string" unless number.is_a?(String)
    raise "Train number can't be blank" if number.empty?
    raise "Train number can't contain more than 20 characters" if number.length > 20
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
