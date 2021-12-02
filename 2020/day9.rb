#!/usr/bin/env ruby

class Array
  def sum
    inject {|a,b| a+b}
  end
end

numbers = STDIN.read.split.map(&:to_i)
preamble_length = ARGV.first.to_i
invalid_number = nil
preamble_length.upto(numbers.length) do |i|
  current_target = numbers[i]
  pairs = numbers[(i - preamble_length) ... i].combination(2).reject { |x| x[0] == x[1] } 
  matches = pairs.select { |x| x[0] + x[1] == current_target }
  if matches.empty?
    puts "Fail! #{current_target}"
    invalid_number = current_target
    break
  end
end

encryption_weakness_set = []
numbers.each_with_index do |n, i|
  i.upto(numbers.length) do |j|
    test_set = numbers[i .. j]
    if test_set.sum == invalid_number
      encryption_weakness_set = test_set
      break
    elsif test_set.sum > invalid_number
      break
    end
  end
  break unless encryption_weakness_set.empty?
end

puts "#{encryption_weakness_set.inspect} => #{encryption_weakness_set.min} + #{encryption_weakness_set.max} = #{encryption_weakness_set.min + encryption_weakness_set.max}"
