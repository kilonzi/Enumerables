# The Enumarable project: Creating own methods

# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum unless block_given?

    tmp = is_a?(Range) ? to_a : self
    i = 0
    result = []
    while i < tmp.size
      result << yield(tmp[i])
      i += 1
    end
    result
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    result = []
    k = 0
    my_each do |v|
      result << yield(k, v)
      k += 1
    end
    result
  end

  def my_select
    return to_enum :my_select unless block_given?

    selected_items = []
    my_each { |i| selected_items.push(i) if yield(i) }
    selected_items
  end

  # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_all?
    return true if self == []
    truth = true
    if block_given?
      (0...length).each do |i|
        truth = yield(self[i])
        return truth if truth == false
      end
    else
      (0...length).each do |i|
        return false if self[i].nil? || self[i] == false
      end
      return true
    end
    truth
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif pattern.class == Class
      my_each { |i| return true if i.class == pattern }
    elsif pattern.class == Regexp
      my_each { |i| return true if i =~ pattern }
    elsif pattern.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i == pattern }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif pattern.class == Class
      my_each { |i| return false if i.class == pattern }
    elsif pattern.class == Regexp
      my_each { |i| return false if i =~ pattern }
    elsif pattern.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i == pattern }
    end
    true
  end

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operand = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operand = arr.shift
    elsif args[1].nil? && block_given?
      operand = args[0]
    else
      operand = args[0]
      symbol = args[1]
    end

    arr[0..-1].my_each do |i|
      operand = if symbol
                  operand.send(symbol, i)
                else
                  yield(operand, i)
                end
    end
    operand
  end
  # rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_count
    size
  end

  # NB: Commented because it was amended in Step 8 of the project

  # def my_map
  #   raise LocalJumpError, 'You have not given a block to the method' unless block_given?
  #   mapped = []
  #   self.my_each {|x|mapped.push(yield(x))}
  #   mapped
  # end

  def my_map(arg = nil)
    return to_enum :my_select unless block_given?

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
end

def multiply_els(arr)
  arr.my_inject(1) { |a, b| a * b }
end
# rubocop:enable Metrics/ModuleLength
