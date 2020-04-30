letters = ('a'..'z').to_a
vowels = %w{a e i o u y}
result = {}

letters.each_with_index do |letters, index|
  if vowels.include?(letters)
    result[letters] = index + 1
  end
end

puts result
