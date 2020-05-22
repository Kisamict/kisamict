def perform_numbers(array)
  yield(array)
end

perform_numbers([1,4,5,4,6,7]) do |array|
  result = {}
  array.each_with_index { |elem, idx| result[idx+1] = elem }
  result
end
