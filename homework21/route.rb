require_relative "station.rb"

class Route
  @@all = {}

  attr_reader :stations, :name

  def self.all
    @@all
  end

  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]
    validate
    @@all[self] = self.stations
  end

  def validate
    raise "Route must contain only stations" unless stations.all? { |station| station.is_a?(Station) }
    raise "Route must consist of two different stations" if stations.first == stations.last
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
end
