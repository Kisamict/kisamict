def perform_strings(array)
   yield(array)
end

perform_strings(["Hello world", "My name is Andrew", "And I'm 23 years old"]) do |array|
  array.max_by {|v| v.count(" ")}
end
