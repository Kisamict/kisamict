require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :volume, :filled_volume

  def initialize(volume)
    @volume = volume
    validate
    @filled_volume = 0
  end

  def fill_volume(num)
    return if (@filled_volume + num) > @volume

    @filled_volume += num
  end

  def available_volume
    @volume - @filled_volume
  end

  def validate
    raise "Wagon volume can't be a zero and must contain only numbers" if volume.zero?
  end
end
