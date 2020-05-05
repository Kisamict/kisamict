puts "Enter the number of day"
day = gets.chomp.to_i
puts "Enter the current month"
month = gets.chomp.to_i
puts "Enter the current year"
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  months[1] = 29
end

if month == 1
  puts day
else
  puts months[0..(month-2)].inject(:+) + day
end