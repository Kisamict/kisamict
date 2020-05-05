def ask(string)

  time = Time.now
  year = time.strftime("%Y").to_i
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ? year = 366 : year = 365

  if string.class != String
    puts "ERROR: This is not a string!"
  else
    case string
    when "time"
      puts time.strftime("%k:%M")
    when "date"
      puts time.strftime("%d of %B, %Y")
    when "day"
      puts time.strftime("Today is %A")
    when "remaining days"
      puts year - time.strftime("%j").to_i
    when "remaining weeks"
      puts 52 - time.strftime("%V").to_i
    else
      puts "Error: that argument is not exists"
    end
  end
end
