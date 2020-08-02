# frozen_string_literal: true

require_relative '../errors/errors'

module Validateable
  attr_reader :valid

  def validate!(attribute)
    raise AttributeValidationError.new('Invalid attribute value', self.class) unless attr_valid?(attribute)
    self.valid = true
  end

  private

  attr_writer :valid

  def attr_valid?(attribute)
    case attribute
    when String
      !(attribute.empty? || attribute.size > 50)
    when Integer
      !attribute.zero?
    else
      false
    end
  end
end
