puts "Первое число"
a = gets.chomp.to_f

puts "Второе число"
b = gets.chomp.to_f

puts "Третье число"
c = gets.chomp.to_f

d = b ** 2 - 4 * a *c

if d > 0
 x1 = (-b + Math.sqrt(d)) / 2 ** a
 x2 = (-b - Math.sqrt(d)) / 2 ** a
 puts "Дискриминант #{d}, первый корень #{x1}, второй корень #{x2}"
elsif d == 0
 x1 = (-b + Math.sqrt(d)) / 2 ** a
 puts "дискриминант #{d}, корень #{x1}"
elsif d < 0
 puts  "#{d} Корней нет"
end
