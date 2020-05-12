def average(array)
  return puts 0 unless array.all?(Integer)
  p array.inject(:+) / array.size
end
