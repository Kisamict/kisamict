require_relative 'wagon'
require_relative 'modules/validateable'
require_relative 'modules/loggable'

class CargoWagon < Wagon
  include Validateable
  include Loggable

  attr_reader :volume, :filled_volume

  def initialize(volume)
    validate!(volume)

    @volume = volume
    @filled_volume = 0

    write_log("Volume: #{volume} |")

  rescue AttributeValidationError
    self.valid = false
  end

  def available_volume
    @available_volume = volume - filled_volume
  end

  def fill_volume(num)
    raise VolumeExceededError.new('Volume exceeded', self.class) if num > available_volume

    @filled_volume += num
  rescue VolumeExceededError => e
    e.message
  end
end
