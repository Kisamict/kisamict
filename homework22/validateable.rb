require_relative 'errors/errors'

module Validator
  def validate!(attribute)
    raise AttributeValidationError.new("Invalid attribute value", self.class) unless attr_valid?(attribute)
  end

  private

  def attr_valid?(attribute)
    case attribute
    when String
      !(attribute.empty? || attribute.size > 50)
    when Integer
      !(attribute.zero?)
    else
      false
    end
  end
end
