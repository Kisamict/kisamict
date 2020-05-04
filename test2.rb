name = []
price = []
@value = []
result = {}

loop do
  puts "Введите название товара:"
  input = gets.chomp.to_s
  break if input == "stop"
  name << input
  puts "Введите цену товара"
  price << gets.chomp.to_f
  puts "Введите колличество товара"
  @value << gets.chomp.to_f
end


test = {}
name.each {|value| result[value] = value }

price.each_with_index do |v, i|
  test[v] = @value[i]
end
