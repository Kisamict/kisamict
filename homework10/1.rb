def perform_strings(array)
   yield(array)
end

perform_strings(["Hello world", "My name is Andrew", "And I'm 23 years old"]) do |array|
  spaces_counter = []
  array.each { |elem| spaces_counter << elem.count(" ") }
  array[spaces_counter.index(spaces_counter.max)]
end
