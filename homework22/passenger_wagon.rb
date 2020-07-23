require_relative 'wagon'
require_relative 'logable'
require_relative 'validateable'

class PassengerWagon < Wagon
  include Logger
  include Validator

  attr_reader :seats, :occupied_seats, :available_seats

  def initialize(seats)
    validate!(seats)
    return unless valid?

    @seats = seats
    @occupied_seats = 0
    @available_seats = seats - occupied_seats

    write_log("Seats: #{seats} |")
  end

  def occupy_seat
    raise AllSeatsOccupiedError, 'All seats is occupied' if @occupied_seats == @seats
  rescue AllSeatsOccupiedError => e
    write_error(e)
  else
    @occupied_seats += 1
  end
end
