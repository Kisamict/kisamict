require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super
  end

  def hook(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end
