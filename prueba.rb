

    def my_each(array) 
      w = 0
      while w < array.size      
        yield(array[w]) 
        w += 1
      end
  end

  # my_each([2,10,12,15]) {|e| puts e + e}

  # def my_each_with_index(array)
  #     w = 0
  #     while w < array.size
  #       yield(array[w], w)
  #       w += 1
  #     end
  #       array
  #  end

  #  my_each_with_index([2,10,12,15]) {|e, index| puts (e + e) if index.odd?}

  def my_select(array)
    second_array = []
    my_each(array) do |w|
      if yield (w)
        second_array.push(w)
      end
    end
    second_array
  end

  
  puts my_select([1, 2, 3]){|x| x != 2}  