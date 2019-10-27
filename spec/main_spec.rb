# frozen_string_literal: true

require 'rspec/autorun'
require './sample1.rb'

RSpec.describe Enumerable do
  describe '=>My All?' do
    it 'Should evaluate a block if one given:-The test expects True' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(true)
      expect([1, 2i, 3.14].my_all?(Numeric)).to eq(true)
      expect(%w[ant bear cat].my_all?(/a/)).to eq(true)
      expect([nil, true, 99].my_all?).to eq(false)
    end
  end

  describe '=>My Each' do
    it 'Provides an enumeration for items and if block is given the applies the block before return the enumation' do
      expect([1, 2, 3, 5].my_each { |i| i }).to eq([1, 2, 3, 5])
      expect([1, 2, 3, 5].my_each { |i| i * 1 }).to eq([1, 2, 3, 5])
      expect([1, 2, 3, 5].my_each { |i| i * 0 }).to eq([0, 0, 0, 0])
      expect([1, 2, 3, 5].my_each).yield_self
    end
  end

  describe '=>My Each with Index' do
    it 'Returns an enumerator if no block is given, else yields' do
      expect([1, 2, 3, 5].my_each_with_index { |k, v| v }).to eq([1, 2, 3, 5])
      expect([1, 2, 3, 5].my_each_with_index { |k, v| v + 1 }).to eq([2, 3, 4, 6])
      expect([1, 2, 3, 5].my_each_with_index { |k, v| v * 0 }).to eq([0, 0, 0, 0])
      expect([1, 2, 3, 5].my_each_with_index { |k, v| k * v }).to eq([0, 2, 6, 15])
      expect([1, 2, 3, 5].my_each_with_index).yield_self
    end
  end

  describe '=> My Select' do
    it 'Returns an enumerator if no block given else yields' do
      expect([1, 2, 3, 4].my_select(&:even?)). to eq([2, 4])
      expect([1, 2, 3, 5].my_select).yield_self
    end
  end

  describe '=> My Any?' do
    it 'Check if a collection"s item fits any of the provided test,regex,class' do
      expect([1, 2, 3, 4].my_any?(&:even?)). to eq(true)
      expect([11, 21, 31, 41].my_any? { |i| i == 0 }). to eq(false)
      expect(%w[ant bear cat].my_any?(/a/)).to eq(true)
    end
  end

  describe '=> My None?' do
    it 'Check if a collection"s item fits doesn"t fit of the provided test,regex,class' do
      expect([1, 2, 3, 4].my_none?(&:even?)). to eq(false)
      expect([11, 21, 31, 41].my_none? { |i| i == 0 }). to eq(true)
      expect(%w[ant bear cat].my_none?(/a/)).to eq(false)
    end
  end
end
