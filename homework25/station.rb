# frozen_string_literal: true

require_relative 'modules/loggable'
require_relative 'modules/validateable'

class Station
  include Loggable
  include Validateable

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
    self.valid = false
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.find_all { |train| train.class == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  private

  def station_info
    "Name: #{name} | "\
    "Trains: #{trains} |"
  end
end
