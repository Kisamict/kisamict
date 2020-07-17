class Station
  @@all = []

  def self.all
    @@all
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate
    @trains = []
    @@all << self
  end

  def each_train(&block)
    trains.each { |train| yield(train) }
  end

  def validate
    raise "Station name can't be blank" if name.empty?
    raise "Station name can't contain more than 20 characters" if name.length > 20
    raise "Station name must be a string" unless name.is_a?(String)
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
