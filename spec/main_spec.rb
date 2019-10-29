# frozen_string_literal: true

require 'rspec/autorun'
require './main.rb'

RSpec.describe Enumerable do
  describe '=>My All?' do
    context 'When a Block is given' do
      it{expect(%w[an bear cat].my_all? { |word| word.length >= 3 }).to eq(false)}
    end
    context 'When a Class is passed' do  
      it{expect([1, 2, 3].my_all?(Numeric)).to eq(true)}
    end
    context 'When a Regex is passed' do
      it{expect(%w[ant bear cat].my_all?(/a/)).to eq(true)}
    end
    context 'When NIL is passed' do
      it{expect([nil, true, 99].my_all?).to eq(false)}
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
    context 'Select the value' do
      it{expect([1, 2, 3, 5].my_each_with_index { |_k, v| v }).to eq([1, 2, 3, 5])}
    end
    context 'Value add something' do
      it{expect([1, 2, 3, 5].my_each_with_index { |_k, v| v + 1 }).to eq([2, 3, 4, 6])}
    end
    context 'Value multiplied by zero' do
      it{expect([1, 2, 3, 5].my_each_with_index { |_k, v| v * 0 }).to eq([0, 0, 0, 0])}
    end
    context 'Value multiplied by index' do
      it{expect([1, 2, 3, 5].my_each_with_index { |k, v| k * v }).to eq([0, 2, 6, 15])}
    end
    context 'When nothing is passed' do
      it{expect([1, 2, 3, 5].my_each_with_index).yield_self}
    end
  end

  describe '=> My Select' do
    context 'When class is passed' do
      it { expect([5, 3, 4, 9].my_select(&:odd?)). to eq([5, 3, 9]) }
    end
    context 'When lowest number is passed' do
      it { expect([11, 21, 31, 41].my_select { |i| i == 11 }). to eq([11]) }
    end
  end

  describe '=> My Any?' do
    context 'When class is passed' do
      it { expect([5, 3, 7, 9].my_any?(&:even?)). to eq(false) }
    end
    context 'When lowest number is passed' do
      it { expect([11, 21, 31, 41].my_any? { |i| i == 11 }). to eq(true) }
    end
    context 'When regex is passed' do
      it { expect(%w[ant bear cat].my_any?(/q/)).to eq(false) }
    end
  end

  describe '=> My None?' do
    context 'When class is passed' do
      it { expect([1, 2, 3, 4].my_none?(&:even?)). to eq(false) }
    end
    context 'When lowest number is passed' do
      it { expect([11, 21, 31, 41].my_none? { |i| i == 11 }). to eq(false) }
    end
    context 'When regex is passed' do
      it { expect(%w[ant bear cat].my_none?(/a/)).to eq(false) }
    end
  end
end
