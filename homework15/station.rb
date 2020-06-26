class Station
  @@all_stations = []

  attr_reader :name, :trains

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.find_all{ |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
