#!/usr/bin/env ruby

class Array
  def sum
    inject {|a,b| a+b}
  end

  def product
    inject {|a,b| a*b}
  end
end

def find_terms n, terms, target
  combinations = n.combination(terms).select { |x| x.sum == target } 
end

numbers = ARGF.read.split.map(&:to_i)

(find_terms(numbers, 2, 2020) + find_terms(numbers, 3, 2020)).map do |set|
  p set
  p set.product
end
