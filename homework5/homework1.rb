def min_and_max(numbers)
  arr = numbers.split(" ")
  arr = arr.sort
  puts arr.first
  puts arr.last
end

min_and_max("2 4 1 5 7 2 4")
