puts "Первая сторона"
a = gets.chomp.to_f

puts "Вторая сторона"
b = gets.chomp.to_f

puts "Третья сторона"
c = gets.chomp.to_f

array = [a,b,c].max

if array ** 2 == a ** 2 + b ** 2
  puts "Треугольник прямоугольный"
elsif array ** 2 == c ** 2 + b ** 2
  puts "Треугольник прямоугольный"
elsif array ** 2 == c ** 2 + a ** 2
  puts "Треугольник прямоугольный"
end

if a == b && c == b && a ==c
  puts "Треугольник равносторонний"
end

if a == b || b == c || a == c
  puts 'Треугольник равнобедренный'
end
