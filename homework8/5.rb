def diffs(array)
  return puts 0 unless array.all?(Integer)
  result = []
  array.each do |num|
    array.each do |num2|
      result.push([num, num2]) if num2 - num == 2
    end
  end
  p result
end
