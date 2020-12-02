#!/usr/bin/env ruby

class Password
  attr_accessor :min, :max, :char, :password

  def self.from_line line
    x = new
    terms = line.split(/\W+/)
    x.min = terms[0].to_i
    x.max = terms[1].to_i
    x.char = terms[2]
    x.password = terms[3]
    x
  end

  def meets?
    count = password.split('').select { |x| x == char}.length
    count >= min && count <= max
  end

  def meets2?
    terms = password.split('')
    (terms[min-1] == char) ^ (terms[max-1] == char)
  end
end

passwords = ARGF.read.split("\n").map {|l| Password.from_line l}
puts "problem 1: #{passwords.select(&:meets?).length}"
puts "problem 2: #{passwords.select(&:meets2?).length}"
