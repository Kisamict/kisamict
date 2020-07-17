module Validateable
  def valid?
    validate
    true
  rescue
    false
  end
end
