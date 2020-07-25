require_relative '../logable'

class AttributeValidationError < StandardError
  include Logger

  def initialize(message, where_from)
    super(message)
    write_error(self, where_from)
  end
end

class AllSeatsOccupiedError < StandardError
  include Logger

  def initialize(message, where_from)
    super(message)
    write_error(self, where_from)
  end
end

class VolumeExceededError < StandardError
  include Logger

  def initialize(message, where_from)
    super(message)
    write_error(self, where_from)
  end
end

class RouteAttributeError < StandardError
  include Logger

  def initialize(message, where_from)
    super(message)
    write_error(self, where_from)
  end
end
