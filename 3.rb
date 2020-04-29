def fibonacci(n)
  if n < 3
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

(1..16).each {|n| puts "#{fibonacci(n)}, "}


array = [0,1]
n = 0
while n < 100 do
  n = array[-2] + array[-1]
  array << n
end

puts array
