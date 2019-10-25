#The Enumarable project: Creating own methods

# frozen_string_literal: true

module Enumerable

    def my_each
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      for el in self
        yield el
      end
    end

    def my_each_with_index
        raise LocalJumpError, 'You have not given a block to the method' unless block_given?
        i = 0
        for el in self
            yield i,el
            i+=1 
        end
    end

    def my_select
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      selected_items = []
      my_each { |i| selected_items.push(i) if yield(i) }
      selected_items
    end

    def my_all?
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      result = true
      self.my_each do |e|
        unless yield(e)
          result = false
          break
        end
      end
      result
    end

    def my_any?
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      result = false
      self.my_each do |e|
        unless yield(e)
          result = true
          break
        end
      end
      result
    end

    def my_none?
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      return true if !self.my_any?{|x| yield x}
    end
    
    def my_count
      self.size
    end

    # NB: Commented because it was amended in Step 8 of the project

    # def my_map
    #   raise LocalJumpError, 'You have not given a block to the method' unless block_given?
    #   mapped = []
    #   self.my_each {|x|mapped.push(yield(x))}
    #   mapped
    # end

    def my_map(arg = nil)
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      arr = []
      my_each do |i|
        if !arg.nil?
          arr.push(arg.call(i))
        else
          arr.push(yield(i))
        end
      end
      arr
    end

    def my_inject(obj=nil)
      raise LocalJumpError, 'You have not given a block to the method' unless block_given?
      accumulator = obj ? obj : 0
      self.my_each do |e|
        accumulator = yield(accumulator, e)
      end
      accumulator
    end
end

#BLOCKS & PROCS

def multiply_els(arr)
  arr.my_inject(1) { |a, b| a * b }
end

a = [1,2,64].my_each{|n| n}
p a == [1,2,64]
c = multiply_els([2, 4, 5])
p c == 40
