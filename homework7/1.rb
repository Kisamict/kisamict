def score_throws(array)

  return p 0 if array.empty?

  result = array.reduce(0) do |score, r|
    next score += 5 if (5..10).include?(r)
    next score += 10 if (0...5).include?(r)
    score
  end

  result += 100 if array.all?{|element| element < 5}
  p result
end

score_throws([1,2,3,7])
