require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :seats, :occupied_seats, :available_seats

  def initialize(seats)
    @seats = seats
    validate
    @occupied_seats = 0
    @available_seats = seats - occupied_seats
  end

  def occupy_seat
    raise "All seats are occupied" if @occupied_seats == @seats

    @occupied_seats += 1
  end

  private

  def validate
    raise "Wagon's amount of seats can't be a zero and must contain only numbers" if seats.zero?
  end
end
