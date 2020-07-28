module Enumerable
  
    def my_each(array) 
        w = 0
        while w < array.size      
          yield(array[w]) 
          w += 1
        end
    end

  def my_each_with_index
  end 
  
end
