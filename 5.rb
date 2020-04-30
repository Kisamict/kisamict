puts "Enter the number of day"
day = gets.chomp.to_i
puts "Enter the current month"
month = gets.chomp.to_i
puts "Enter the current year"
year = gets.chomp.to_i

result = 0
years = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  years[1] = 29
end

years.each_with_index do |days, months|
  break if months == month - 1
  result += days
  end

puts "Date's serial number is  #{result + day}!"
