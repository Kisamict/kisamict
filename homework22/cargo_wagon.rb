require_relative 'wagon'
require_relative 'validateable'
require_relative 'logable'

class CargoWagon < Wagon
  include Validator
  include Logger

  attr_reader :volume, :filled_volume, :available_volume

  def initialize(volume)
    validate!(volume)

    @volume = volume
    @filled_volume = 0
    @available_volume = volume - filled_volume

    write_log("Volume: #{volume} |")

  rescue AttributeValidationError
  end

  def fill_volume(num)
    raise VolumeExceededError.new('Volume exceeded', self.class) if num > available_volume
    @filled_volume += num
  rescue VolumeExceededError
  end
end
