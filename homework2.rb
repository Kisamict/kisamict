puts "Первая сторона"
a = gets.chomp.to_f

puts "Вторая сторона"
b = gets.chomp.to_f

puts "Третья сторона"
c = gets.chomp.to_f

sides = [a,b,c].sort
hypotenuse = sides.last
side_a = sides[0]
side_b = sides[1]

formula = hypotenuse ** 2 == side_a ** 2 + side_b ** 2

if formula
  puts "Треугольник прямоугольный"
end

if formula && side_a == side_b
  puts "Треугольник прямоугольный и равнобедренный"
end

if side_a == side_b && hypotenuse == side_b && side_a == hypotenuse
  puts "Треугольник равносторонний"
end
