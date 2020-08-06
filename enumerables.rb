module Enumerable
  def my_each
    if block_given?
      w = 0
      while w < size
        yield(self[w]) if is_a? Array
        yield(to_a[w]) if is_a? Hash
        yield(to_a[w]) if is_a? Range
        w += 1
      end
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      w = 0
      while w < size
        yield(self[w], w) if is_a? Array
        yield(to_a[w], w) if is_a? Hash
        yield(to_a[w], w) if is_a? Range
        w += 1
      end
    else
      to_enum
    end
  end

  def my_select
    if block_given?
      my_array = []
      my_each do |w|
        my_array.push(w) if yield(w) == true
      end
      my_array
    else
      to_enum
    end
  end

  def my_all?(argument = nil)
    if block_given?
      my_each { |w| return false if yield(w) == false }
    elsif [Integer, Float, String].include? argument.class
      my_each { |w| return false unless w == argument }
    elsif argument.class == Regexp
      my_each { |w| return false unless w =~ argument }
    elsif argument.is_a?(Class)
      my_each { |w| return false unless w.is_a?(argument) }
    elsif argument
      my_each { |w| return false unless w == argument }
    else argument.nil? && !block_given?
         my_each { |w| return false unless w }
    end
    true
  end

  def my_any?(argument = nil)
    if block_given?
      my_each { |w| return true if yield(w) == true }
    elsif [Integer, Float, String].include? argument.class
      my_each { |w| return true if argument == w }
    elsif argument.class == Regexp
      my_each { |w| return true if w =~ argument }
    elsif argument.is_a?(Class)
      my_each { |w| return true if w.is_a?(argument) }
    else
      !block_given? && argument.nil?
      my_each { |w| return true if w }
    end
    false
  end

  def my_none?(argument = nil)
    if block_given?
      my_each { |w| return false if yield(w) == true }
    elsif [String, Float, Integer].include? argument.class
      my_each { |w| return false if w == argument }
    elsif argument.class == Regexp
      my_each { |w| return false if w =~ argument }
    elsif argument.is_a?(Class)
      my_each { |w| return false if w.is_a?(argument) }
    else
      !block_given? && argument.nil?
      my_each { |w| return false if w }
    end
    true
  end

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

  def my_map(proc = nil)
    second_array = []
    if block_given?
      my_each { |w| second_array.push(yield(w)) } unless proc
      my_each { |w| second_array.push(proc.call(w)) } if proc
    elsif proc
      my_each { |w| second_array.push(proc.call(w)) }
    else
      return to_enum
    end
    second_array
  end

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
      elsif !sym.nil?
        if sym.class == Symbol || sym.class == String
          acc = argument
          my_each { |w| acc = acc.send(sym, w) }
          acc
        end
      else
        "#{acc} TypeError"
      end

    end
  end

  def multiply_els
    my_inject(1) { |multiplier, num| multiplier * num }
  end
end
