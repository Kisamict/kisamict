def reverse_string(array)
  return p Array.new unless array.all?(String)

  result = []
  reversed = []

  array.each do |str|
    split_string = str.split("")
    str.size.times {reversed << split_string.pop }
    result << reversed.join("")
    reversed.clear
  end
  p result
end
