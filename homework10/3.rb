def my_map_with_index(array)
  return unless block_given?
  output = []

  for elem in array
    output << yield(elem, array.index(elem))
  end
  output
end
