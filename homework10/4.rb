def my_inject(array, arg)

  if block_given?

    array.each { |elem| arg = yield(arg, elem) }
    arg

  else

    return unless array.all?(Numeric)

    result = array[0]

    array.each do |elem|
      next if array.index(elem) == 0
      result = result.send(arg, elem)
    end

    result
  end
end
