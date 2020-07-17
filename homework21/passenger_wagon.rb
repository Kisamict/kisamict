require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :seats, :occupied_seats

  def initialize(seats)
    @seats = seats
    validate
    @occupied_seats = 0
  end

  def occupy_seat
    return if @occupied_seats == @seats

    @occupied_seats += 1
  end

  def available_seats
    @seats - @occupied_seats
  end

  def validate
    raise "Wagon's amount of seats can't be a zero and must contain only numbers" if seats.zero?
  end
end
