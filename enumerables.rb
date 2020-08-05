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
  #  [2, 10, 12, 15].my_each { |e| puts e + e }

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
  #  [2,10,12,15].my_each_with_index {|e, index| puts (e + e) if index.odd?}

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
  # puts([1, 2, 3].my_select { |x| x != 2 })

  def my_all?(argument = nil)
    if block_given?
      my_each { |w| return false if yield(w) == false }
    elsif [Integer, Float, String].include? argument.class
      my_each { |w| return false unless w == argument }
    elsif argument.class == Regexp
      my_each { |w| return false unless w =~ argument }
    elsif argument.class == Class
      my_each { |w| return false unless w.class == argument }
    else !argument && !block_given?
         my_each { |w| return false unless w }
    end
    true
  end
  # puts(["j" "h"].my_all?('h'))
  # puts([0.2, 2.3].my_all?(Float))
  # puts([1, 1, 2].my_all? { |x| x == 1 })
  # puts(%w[cat dog cat].my_all?('cat'))
  # puts(%w[dog dog dog].my_all?('dog'))
  # puts([3, 5, 2].my_all?(Integer))
  # puts([1, 2, 1].my_all?(1))

  def my_any?(argument = nil)
    if block_given?
      my_each { |w| return true if yield(w) == true }
    elsif [Integer, Float, String].include? argument.class
      my_each { |w| return true if argument == w }
    elsif argument.class == Regexp
      my_each { |w| return true if w =~ argument }
    elsif argument.class == Class
      my_each { |w| return true if w.class == argument }
    else !block_given? && !argument
         my_each { |w| return true if w }
    end
    false
  end
  # puts [1, 2, 'j'].my_any?(String)
  # puts [1, 2, 3].my_any?(String)
  # puts([1, 1, 2].my_any? { |x| x == 1 })
  # puts(%w[cat dog cat].my_any?('cat'))
  # puts(%w[dog dog dog].my_any?('cat'))
  # puts([3, 5, 2].my_any?(Integer))

  def my_none?(argument = nil)
    if block_given?
      my_each { |w| return false if yield(w) == true }
    elsif [String, Float, Integer].include? argument.class
      my_each { |w| return false if w == argument }
    elsif argument.class == Regexp
      my_each { |w| return false if w =~ argument }
    elsif argument.class == Class
      my_each { |w| return false if w.class == argument }
    else !argument && !block_given?
         my_each { |w| return false if w }
    end
    true
  end
  # puts (["cat", "cat" "cat"].my_none? { |word| word.length < 2 })
  # puts([1, 2].my_none? { |x| x == 1 })
  # puts(['hello'].my_none? { |x| x == 1 })
  # puts(%w[dog dog dog].my_none?('cat'))

  def my_count(argument = nil)
    x = 0
    if block_given?
      my_select { |w| yield(w) }.size
    elsif !block_given? && !argument.nil?
      my_each { |w| x += 1 if argument == w }
      x
    else
      my_each { x += 1 }
      x
    end
  end
  #  puts ([1,2,3,4,8].my_count {|w| w%2 == 0})
  #  puts ([1,2,3,4,8].my_count)
  #  puts ([1, 2, 4, 23, 34, "w", "w"].my_count("w"))

  def my_map(&block)
    if block_given?
      second_array = []
      my_each { |w| second_array.push(block.call(w)) }
      second_array
    else to_enum
    end
  end
  #  puts([1, 2, 3].my_map { |x| x + 3 })
  #  puts([1, 2, 3].my_map { |x| x <= 3 })

  def my_inject(argument = nil, sym = nil)
    array = to_a
    if block_given?
      if !argument.nil?
        my_each { |w| argument = yield(argument, w) }
      else
        argument = array[0]
        array[1..-1].my_each { |w| argument = yield(argument, w) }
      end
      argument
    elsif !block_given?
      if argument.class == Symbol || argument.class == String
        acc = nil
        my_each { |w| acc = acc.nil? ? w : acc.send(argument, w) }
        acc
      else
        sym.nil?
        if sym.class == Symbol || sym.class == String
          acc = argument
          my_each { |w| acc = acc.send(sym, w) }
          acc
        end
      end
    end
  end

  #  puts([2, 2, 3, 4].my_inject(2) { |sum, num| sum + num })
  #  puts([1, 2, 3, 2].my_inject(3, :-))
  #  puts([1, 2, 3, 2].my_inject(:-))

  def multiply_els
    my_inject(1) { |multiplier, num| multiplier * num }
  end
  # puts ([2,4,5].multiply_els)
  # end module
end
