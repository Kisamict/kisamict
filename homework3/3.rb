puts "Первое число"
a = gets.chomp.to_f

puts "Второе число"
b = gets.chomp.to_f

puts "Третье число"
c = gets.chomp.to_f

discriminant = b ** 2 - 4 * a *c
d = Math.sqrt(discriminant)

if discriminant > 0
 x1 = (-b + d) / 2 * a
 x2 = (-b - d) / 2 * a
 puts "Дискриминант #{discriminant}, первый корень #{x1}, второй корень #{x2}"
elsif discriminant == 0
 x1 = (-b + d) / 2 * a
 puts "дискриминант #{discriminant}, корень #{x1}"
elsif discriminant < 0
 puts  "дискриминант #{discriminant}. Корней нет"
end
