# frozen_string_literal: true

require_relative 'validateable'
require_relative 'station'
require_relative 'loggable'

class Route
  include Validateable
  include Loggable

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

    self.class.all[self] = stations
    write_log("Name: #{name}")

    # rescue RouteAttributeError
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
    unless [from, to].all? { |attr| attr.is_a?(Station) }
      raise RouteAttributeError.new('Arguments are not stations', self.class)
    end
    raise RouteAttributeError.new('Same station passed', self.class) if from == to
  end
end
