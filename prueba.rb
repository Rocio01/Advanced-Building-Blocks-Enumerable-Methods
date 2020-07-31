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
end
