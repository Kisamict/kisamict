require_relative 'logable'
require_relative 'validateable'

class Station
  include Logger
  include Validator

  class << self
    def all
      @all ||= []
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    validate!(name)

    @name = name
    @trains = []

    self.class.all << self
    write_log(station_info)

  rescue AttributeValidationError
  end

  def station_info
    "Name: #{name} | "\
    "Trains: #{trains} | "
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.find_all { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
