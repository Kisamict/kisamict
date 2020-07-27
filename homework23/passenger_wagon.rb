require_relative 'wagon'
require_relative 'loggable'
require_relative 'validateable'

class PassengerWagon < Wagon
  include Loggable
  include Validateable

  attr_reader :seats, :occupied_seats

  def initialize(seats)
    validate!(seats)

    @seats = seats
    @occupied_seats = 0

    write_log("Seats: #{seats} |")

  # rescue AttributeValidationError
  end

  def available_seats
    @available_seats = seats - occupied_seats
  end

  def occupy_seat
    raise AllSeatsOccupiedError.new('All seats occupied', self.class) if @occupied_seats == @seats
    
    @occupied_seats += 1
  # rescue AllSeatsOccupiedError
  #   nil
  end
end
