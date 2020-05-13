def even_odd(array)
  return puts 0 unless array.all?(Integer)

  odd = 0
  even = 0

  for i in array
    odd +=1 if i.odd?
    even += 1 if i.even?
  end

  p even > odd ? even - odd : odd - even

end
