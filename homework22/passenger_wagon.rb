require_relative 'wagon'
require_relative 'logable'
require_relative 'validateable'

class PassengerWagon < Wagon
  include Logger
  include Validator

  attr_reader :seats, :occupied_seats, :available_seats

  def initialize(seats)
    validate!(seats)

    @seats = seats
    @occupied_seats = 0
    @available_seats = seats - occupied_seats

    write_log("Seats: #{seats} |")

  rescue AttributeValidationError
  end

  def occupy_seat
    raise AllSeatsOccupiedError.new('All seats occupied', self.class) if @occupied_seats == @seats
    @occupied_seats += 1
  rescue AllSeatsOccupiedError
  end
end
