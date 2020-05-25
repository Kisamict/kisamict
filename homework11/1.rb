class Station
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end

class Route

  def initialize(from, to)
    @from = from
    @to = to
    @name = "#{@from.name}-#{@to.name}"
  end

  def list
    return @from.name, @to.name
  end

end

class Train
  attr_reader :speed, :wagons

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def go
    @speed = 40
  end

  def stop
    @speed = 0
  end

  def add_remove(arg)
    return "You can't remove or add wagons until train stops" unless @speed == 0

    case arg
    when "add"
      @wagons += 1
    when "remove"
      @wagons -= 1 unless @wagons == 0
    end
  end
end
