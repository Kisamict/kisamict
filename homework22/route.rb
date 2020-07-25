require_relative 'validateable'
require_relative 'station'
require_relative 'logable'

class Route
  include Validator
  include Logger

  class << self
    def all
      @all ||= {}
    end
  end

  attr_reader :stations, :name

  def initialize(from, to)
    validate!(from, to)

    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]

    self.class.all[self] = self.stations
    write_log("Name: #{name}")

  rescue RouteAttributeError
  end

  def add(station)
    return if @stations.include?(station)

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

  def validate!(from, to)
    raise RouteAttributeError.new("Arguments are not stations", self.class) unless [from, to].all? { |attr| attr.is_a?(Station) }
    raise RouteAttributeError.new("Same station passed", self.class)  if from == to
  end
end
