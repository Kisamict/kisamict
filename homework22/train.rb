require_relative 'instance_counter.rb'
require_relative 'validateable'
require_relative 'logable'

class Train
  include Logger
  include Validator
  include InstanceCounter

  class << self
    attr_accessor :all

    def self.find(number)
      @@all.find { |train| train.number == number }
    end
  end

  attr_reader :wagons, :speed, :type, :route, :number

  def initialize(number)
    validate!(number)
    return unless valid?

    @number = number
    @speed = 0
    @wagons = []

    self.class.all ||= [] << self
    register_instance
    write_log(train_info)
  end

  def train_info
    "Number: #{number}| "\
    "Current station: #{current_station&.name} |"\
    "Route name: #{route&.name} |"
  end

  def each_wagon
    wagons.each_with_index { |wagon, index| yield(wagon, index) }
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
    return unless @station_index

    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index.postitve?
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
end
