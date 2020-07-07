require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :seats

  def initialize(seats)
    @seats = seats
  end

  def validate
    raise "Wagon's amount of seats can't be a zero and must contain only numbers" if seats.zero? 
  end
end
