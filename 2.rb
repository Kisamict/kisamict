array = []
array_element = 5

while array_element < 100
  array << array_element += 5
end

puts array

#Еще вариант

array = Array.new(21){|a| a = a * 5}
puts array
