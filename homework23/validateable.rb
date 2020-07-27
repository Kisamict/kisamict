# frozen_string_literal: true

require_relative 'errors/errors'

module Validateable
  def validate!(attribute)
    raise AttributeValidationError.new('Invalid attribute value', self.class) unless valid?(attribute)
  end

  private

  def valid?(attribute)
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
