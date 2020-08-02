require_relative '../modules/loggable'

class SelfLoggableError < StandardError
  include Loggable

  def initialize(message, klass)
    super(message)
    write_error(self, klass)
  end
end

class AttributeValidationError < SelfLoggableError
end

class AllSeatsOccupiedError < SelfLoggableError
end

class VolumeExceededError < SelfLoggableError
end

class RouteAttributeError < SelfLoggableError
end

class AcceptTrainError < SelfLoggableError
end
