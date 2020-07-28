

 def my_each (array)
     block_given? 
     
     loop  do
        w = 0
        w += 1
        yield (array[w])
         
        break if w < array.size
        
     end
     array
 end 

# def my_each(array) 
#     w = 0
#     while w < array.size      
#       yield(array[w]) 
#       w += 1
#     end

#   end

  my_each([2,10,12,15]) {|e| puts e + e}


