puts "Enter the number of day"
day = gets.chomp.to_i
puts "Enter the current month"
month = gets.chomp.to_i
puts "Enter the current year"
year = gets.chomp.to_i

result = 0
leap_year = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
regular_year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months_amount = (1..12).to_a

if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  year = Hash[*months_amount.zip(leap_year).flatten]
else
  year = Hash[*months_amount.zip(regular_year).flatten]
end

year.each do |key, value|
  break if key == month
  result += value
  end

puts "Date's serial number is  #{result + day}!"
