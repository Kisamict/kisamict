require_relative "train"

class CargoTrain < Train
  def initialize(number)
    super
    @type = "CargoTrain"
  end

  def hook(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end
