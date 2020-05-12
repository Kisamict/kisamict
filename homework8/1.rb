def square(array)
  return puts 0 unless array.all?(Integer)
  p array.map{|x| x ** 2}
end
