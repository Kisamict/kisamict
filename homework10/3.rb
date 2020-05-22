def my_map_with_index(array)

  return p nil unless block_given?
  output = []
  array.each_with_index { |elem, indx| output << yield(elem, indx) }
  return output

end
