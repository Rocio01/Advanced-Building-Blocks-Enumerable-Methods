module Enumerable
  def my_each
    if block_given?
      w = 0
      while w < size
        yield(self[w])
        w += 1
      end
      self
    else
      to_enum
    end
  end
  #   [2, 10, 12, 15].my_each { |e| puts e + e }

  def my_each_with_index
    if block_given?
      w = 0
      while w < size
        yield(self[w], w)
        w += 1
      end
      self
    else
      to_enum
    end
  end
  #   [2,10,12,15].my_each_with_index {|e, index| puts (e + e) if index.odd?}

  def my_select
    if block_given?
      my_array = []
      my_each do |w|
        my_array.push(w) if yield w
      end
      my_array
    else
      to_enum
    end
  end
  puts([1, 2, 3].my_select { |x| x != 2 })

  # end of the module
end
