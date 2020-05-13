def diffs(array)
  return p 0 unless array.all?(Integer)

  array = array.sort
  result = []

  array.each_with_index do |elem, index|
    num = array[index + 1]
    num2 = array[index + 2]
    break if num.nil? || num2.nil?

    result.push([elem, num]) if num - elem == 2
    result.push([elem,num2]) if num2 - elem == 2
  end
  p result
end
