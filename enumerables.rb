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
  #   puts([1, 2, 3].my_select { |x| x != 2 })

  def my_all?(argument = nil)
    my_each { |w| return false unless yield(w) } if block_given?
    my_each { |w| return false unless w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return false unless w =~ argument } if argument.class == Regexp
    my_each { |w| return false unless w.class == argument } if argument.class == Class
    my_each { |w| return false unless w } if !block_given? && !argument
    true
  end
  # puts (['j', 2].my_all?(String))
  # puts([1, 1, 2].my_all? { |x| x == 1 })
  # puts([1, 1, 2].all?(Integer))

  def my_any?(argument = nil)
    my_each { |w| return true if yield(w) } if block_given?
    my_each { |w| return true if w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return true if w =~ argument } if argument.class == Regexp
    my_each { |w| return true if w.class == argument } if argument.class == Class
    my_each { |w| return true if w } if !block_given? && !argument
    false
  end

  # puts [1, 2, 'j'].my_any?(String)
  # puts [1, 2, 3].my_any?(String)
  # puts([1, 1, 2].my_any? { |x| x == 1 })

  def my_none?(argument = nil)
    my_each { |w| return false if yield(w) } if block_given?
    my_each { |w| return false if w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return false if w =~ argument } if argument.class == Regexp
    my_each { |w| return false if w.class == argument } if argument.class == Class
    my_each { |w| return false if w } if !block_given? && !argument
    true
  end
  # puts (["cat", "cat" "cat"].my_none? { |word| word.length < 2 })
  # puts([1, 2].my_none? { |x| x == 1 })
  # puts(['hello'].my_none? { |x| x == 1 })

  def my_count(argument = nil)
    x = 0
    my_each { |w| x += 1 if yield(w) == true } if block_given?
    x if block_given?

    my_each { |w| x += 1 if w == argument } if argument
    x if argument

    my_each { x += 1 } if !argument && !block_given?
    x
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

  def my_inject(num = nil, sym = nil)
    total = num || first
    total = num if !num.class == Symbol
    total = first if num.class == Symbol
    total -= total if total != num && total.class != String
    my_each { |w| total = yield(total, w) } if block_given?
    my_each { |w| total = total.send(sym, w) } if num && sym
    my_each { |w| total = total.send(num, w) } if num.class == Symbol

    total
  end
  #  puts([1, 2, 3, 4].my_inject(2) { |sum, num| sum + num })
  #  puts([1, 2, 3, 2].my_inject(3, :-))

  def multiply_els
    my_inject(1) { |multiplier, num| multiplier * num }
  end
  #  puts ([2,4,5].multiply_els)

  # end of the module
end
