require_relative 'train'
require_relative 'logable'

class CargoTrain < Train
  def initialize(number)
    super
  end

  def hook(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end
