#!/usr/bin/env ruby

class Bag
  attr_accessor :color, :contains_bags, :contained_in, :text_description

  def initialize color
    @color = color
    @contains_bags = []
    @contained_in = []
  end

  def contained bag
    contained_in << bag
  end

  def contains bag, times, bag_graph
    times.times do
      @contains_bags << bag
    end
    bag_graph[bag.color].contained self
  end
end

bag_graph = Hash.new { |h, k| h[k] = Bag.new k }

ARGF.read.each_line do |l|
  color, contains = l.strip.split /\s*bags contain\s*/
  next if contains == "no other bags."
  bag = bag_graph[color]
  bag.text_description = contains
end

bag_graph.values.each do |bag|
  contains = bag.text_description.split ','
  contains.each do |c|
    count, color = c.scan(/(\d+) (.*) bag/)[0]
    bag.contains bag_graph[color], count.to_i, bag_graph
  end
end

containable = bag_graph['shiny gold'].contained_in
set_modified = true
while set_modified do
  set_modified = false
  containable.each do |c|
    c.contained_in.each do |candidate|
      if !containable.index(candidate)
        containable << candidate 
        set_modified = true
      end
    end
  end
end

puts containable.length

descendents = [bag_graph['shiny gold'].contains_bags]
descendents_modified = true
while descendents_modified do
  descendents_modified = false
  next_level = descendents.last.map(&:contains_bags).flatten
  if !next_level.empty?
    descendents_modified = true
    descendents << next_level
  end
end
puts     descendents.flatten.length
