def ask(string)

  return puts "ERROR: This is not a string!" unless string.is_a?(String)

  time = Time.now
  year = time.strftime("%Y").to_i
  leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  year_days = leap_year ? 366 : 365

  case string
  when "time"
    puts time.strftime("%k:%M")
  when "date"
    puts time.strftime("%d of %B, %Y")
  when "day"
    puts time.strftime("Today is %A")
  when "remaining days"
    puts year_days - time.strftime("%j").to_i
  when "remaining weeks"
    puts 52 - time.strftime("%V").to_i
  else
    puts "Error: that argument is not exists!"
  end
end
