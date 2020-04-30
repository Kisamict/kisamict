letters = ('a'..'z').to_a
vowels = %w{a e i o u y}
result = {}

letters.each_with_index do |key, value|
  if vowels.include?(key)
    result[key] = value + 1
  end
end

puts result
