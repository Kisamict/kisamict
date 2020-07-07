require_relative "train"

class PassengerTrain < Train
  def initialize(number)
    super
    @type = "PassengerTrain"
  end

  def hook(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end
