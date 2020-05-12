output = {}
total_price = 0

loop do
  puts "Enter product name:"
  product = gets.chomp.to_s

  break if product == "stop"

  puts "Enter product's price:"
  price = gets.chomp.to_f

  puts "Enter the amount of products:"
  amount = gets.chomp.to_f

  output[product] = { price: price, amount: amount, total: price * amount }
end

puts output

output.each do|key, value|
   total_price += value[:total]
end

puts "The total price is #{total_price}"
