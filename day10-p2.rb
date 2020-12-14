#!/usr/bin/env ruby

class Array
  def sum
    inject {|a,b| a+b}
  end
end

class Node
  attr_accessor :jolts, :children, :unique_paths

  def initialize jolts
    @jolts = jolts
    @children = []
    @unique_paths = 0
  end

  def chains_to? node
    jolts + 3 >= node.jolts
  end

  def chain_to node
    children << node
  end

  def probe indent=0
    # puts (" " * indent) + ({ jolts: jolts, children: children.length }).inspect
    children.each do |child|
      child.probe indent + 2
    end
  end

  def register_paths count
    p({ :where => :register_paths, :jolts => jolts, :count => count, :unique_paths => unique_paths })
    @unique_paths += count
  end

  def push_down_count
    # p({ :where => :push_down_count, :jolts => jolts, :unique_paths => unique_paths })
    children.each do |child|
      child.register_paths unique_paths
    end
  end

  # def unique_paths
  #   if children.empty?
  #     1
  #   else
  #     children.map(&:unique_paths).sum
  #   end
  # end
end

numbers = ARGF.read.split.map(&:to_i)
numbers << (numbers.max + 3)
numbers.sort!

root = Node.new(0)
nodes = [root]
relevant_nodes = [root]

numbers.each do |n|
  node = Node.new(n)
  relevant_nodes = relevant_nodes.select { |candidate| candidate.chains_to? node }
  relevant_nodes.each { |candidate| candidate.chain_to node }
  relevant_nodes << node
  nodes << node
end

root.unique_paths = 1
nodes.each(&:push_down_count)
puts nodes.last.unique_paths
