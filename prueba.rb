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

  def my_all?(argument = nil, &block)
    my_each { |w| return false unless block.call(w) } if block_given?
    my_each { |w| return false unless w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return false unless w =~ argument } if argument.class == Regexp
    my_each { |w| return false unless w.class == argument } if argument.class == Class
    my_each { |w| return false unless w } if !block_given? && !argument
    true
  end
  # puts ['j', 2].my_all?(String)
  # puts([1, 1, 2].my_all? { |x| x == 1 })
  # puts([1, 1, 2].my_all?(Integer))

  def my_any?(argument = nil, &block)
    my_each { |w| return true if block.call(w) } if block_given?
    my_each { |w| return true if w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return true if w =~ argument } if argument.class == Regexp
    my_each { |w| return true if w.class == argument } if argument.class == Class
    my_each { |w| return true if w } if !block_given? && !argument
    false
  end

  # puts [1, 2, 'j'].my_any?(String)
  # puts [1, 2, 3].my_any?(String)
  # puts([1, 1, 2].my_any? { |x| x == 1 })

  def my_none?(argument = nil, &block)
    my_each { |w| return false if block.call(w) } if block_given?
    my_each { |w| return false if w == argument } if [Integer, String].include?(argument.class)
    my_each { |w| return false if w =~ argument } if argument.class == Regexp
    my_each { |w| return false if w.class == argument } if argument.class == Class
    my_each { |w| return false if w } if !block_given? && !argument
    true
  end

  # puts([1, 2].my_none? { |x| x == 1 })
  # puts(['hello'].my_none? { |x| x == 1 })

  # end of the module
end
