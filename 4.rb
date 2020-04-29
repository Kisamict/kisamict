letters = ('a'..'z').to_a
numbers = (1..26).to_a
vowels = %w{a e i o u y}
result = {}

alphabet = Hash[*letters.zip(numbers).flatten]

alphabet.each do |key, value|
  if vowels.include?(key)
    result[key] = value
  end
end

puts result
