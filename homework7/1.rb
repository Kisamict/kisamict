def score_throws(array)
  score = 0
  array.each do |radius|
    if radius > 10
      score += 0
    elsif (5..10).include?(radius)
      score += 5
    elsif radius < 5
      score += 10
    end
    score = 0 if array.empty?
  end
  score += 100 if array.all? {|value| value < 5}
  puts score
end

score_throws([1, 7, 10, 15])
