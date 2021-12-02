#!/usr/bin/env ruby

numbers = ARGF.read.split.map(&:to_i)
numbers << 0
numbers << numbers.max + 3
deltas = []
numbers.sort.each_cons(2) do |cons|
  deltas << (cons[1] - cons[0])
end
segments = deltas.group_by {|x| x}
puts "#{segments[1].length} * #{segments[3].length} = #{segments[1].length * segments[3].length}"
