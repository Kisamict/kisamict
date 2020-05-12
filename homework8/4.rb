def reverse_string(array)
  return p Array.new unless array.all?(String)
  p array.map{|x| x.reverse}
end
