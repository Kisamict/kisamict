
def my_inject(array, arg)

  if block_given?

    result = arg
    for elem in array
      result = yield(result, elem)
    end

  else

    return unless array.all?(Numeric)

    result = array[0]

    for elem in array
      next if array.index(elem) == 0
      result = result.send(arg, elem)
    end

  end
  result
end
