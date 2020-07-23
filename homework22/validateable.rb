require_relative 'logable'

module Validator
  include Logger

  def valid?
    @valid
  end

  def validate!(attribute)
    raise AttributeValidationError, "Attribute value is not valid" unless attr_valid?(attribute)
  rescue AttributeValidationError => e
    write_error(e)
  end

  private

  def attr_valid?(attribute)
    case attribute
    when String
      @valid = true if !(attribute.empty? || attribute.size > 50)
    when Integer
      @valid = true if !(attribute.zero?)
    else
      @valid = false
    end
  end
end
