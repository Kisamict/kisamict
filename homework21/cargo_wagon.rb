require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :volume, :filled_volume, :available_volume

  def initialize(volume)
    @volume = volume
    validate
    @filled_volume = 0
    @available_volume = volume - filled_volume
  end

  def fill_volume(num)
    raise "Volume exceeded" if (@filled_volume + num) > @volume

    @filled_volume += num
  end

  def available_volume
    @volume - @filled_volume
  end

  private

  def validate
    raise "Wagon volume can't be a zero and must contain only numbers" if volume.zero?
  end
end
