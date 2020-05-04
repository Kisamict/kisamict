def sum(array)
  arr2 = []
  arr2 = array.sort_by{|word| word.length}
  puts arr2[-1].length + arr2[0].length
end

sum(%w{one two three four five six seven})
