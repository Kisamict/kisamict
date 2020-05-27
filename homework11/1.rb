class Station
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Route
  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @list = [from, to]
  end

  def list
    @list
  end
end

class Train
  def initialize(number, type, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def go
    @speed += 10
  end

  def speed
    @speed
  end

  def stop
    @speed = 0
  end

  def wagons
    @wagons
  end

  def hook
    @wagons += 1 unless @speed > 0
  end

  def unhook
    @wagons -= 1 unless @wagons <= 0 || @speed > 0
  end
end
