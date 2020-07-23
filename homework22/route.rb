require_relative 'validateable'
require_relative 'station'
require_relative 'logable'

class Route
  include Validator
  include Logger

  class << self
    attr_accessor :all
  end

  attr_reader :stations, :name

  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]
    validate!
    return unless valid?

    Route.all ||= {}
    Route.all[self] = self.stations
    write_log("Name: #{name}")
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

  def validate!
    raise RouteAttributeError,  "Route must contain only stations" unless stations.all? { |station| station.is_a?(Station) }
    raise RouteAttributeError, "Route must consist of two different stations" if stations.first == stations.last
  rescue RouteAttributeError => e
    @valid = false
    write_error(e)
  else
    @valid = true
  end
end
