def even_odd(array)
  return puts 0 unless array.all?(Integer)
  even = array.count{|elem| elem.even?}
  odd = array.count{|elem| elem.odd?}
  p even > odd ? even - odd : odd - even
end
