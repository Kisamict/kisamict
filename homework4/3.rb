array = [0,1]
n = 0
while n < 100 do
  n = array[-2] + array[-1]
  array << n
end

puts array
