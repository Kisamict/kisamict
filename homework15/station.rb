class Station
  @@all = []

  attr_reader :name, :trains

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
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
