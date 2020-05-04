output = {}
total_price = []

loop do
  puts "Enter product name:"
  product = gets.chomp.to_s
  break if product == "stop"
  puts "Enter product's price:"
  price = gets.chomp.to_f
  puts "Enter the amount of products:"
  amount = gets.chomp.to_f
  output[product] = {price: price, amount: amount}
end

puts output

output.each do|key, value|
  puts "The total price for #{key} is #{value.values.inject(:*)}"
  total_price << value.values.inject(:*)
end
puts "The total price is #{total_price.inject(:+)}."
