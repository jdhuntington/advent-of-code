#!/usr/bin/env ruby
require 'set'

class Group
  attr_accessor :answers

  def positive_questions
    positive_answers = Set.new
    answers.each do |a|
      a.split('').each { |char| positive_answers << char }
    end
    positive_answers
  end

  def common_answers
    answers.map {|x| x.split '' }.inject { |acc, val| acc & val }
  end

  def self.from_lines lines
    x = new
    x.answers = lines.split
    x
  end
end

class Array
  def sum
    inject {|a,b| a+b}
  end
end


groups = ARGF.read.split("\n\n").map { |x| Group.from_lines x }
puts groups.length
puts groups.map(&:positive_questions).map(&:length).sum
puts groups.map(&:common_answers).map(&:length).sum
