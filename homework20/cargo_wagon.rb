require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :volume

  def initialize(volume)
    @volume = volume
    validate
  end

  def validate
    raise "Wagon volume can't be a zero and must contain only numbers" if volume.zero?
  end
end
