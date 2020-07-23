require_relative 'wagon'
require_relative 'logable'
require_relative 'validateable'

class CargoWagon < Wagon
  include Logger
  include Validator

  attr_reader :volume, :filled_volume, :available_volume

  def initialize(volume)
    validate!(volume)
    return unless valid?

    @volume = volume
    @filled_volume = 0
    @available_volume = volume - filled_volume

    write_log("Volume: #{volume} |")
  end

  def fill_volume(num)
    raise VolumeExceededError, 'Volume exceeded' if (@filled_volume + num) > @volume
  rescue VolumeExceededError => e
    write_error(e)
  else
    @filled_volume += num
  end
end
