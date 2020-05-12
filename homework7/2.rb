def my_compact(array)
  output = []
  for element in array do
    next unless element == nil
    output << element
  end
  p output
end

my_compact([0, 1, 1, 2, nil, 5, 8, nil, nil, 34])
