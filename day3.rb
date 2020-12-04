#!/usr/bin/env ruby

class Grid
  attr_accessor :rows

  def slide x, y, dx, dy, trees_found=0
    return trees_found if y >= rows.length
    slide(x + dx, y + dy, dx, dy, trees_found + (tree_at?(x,y) ? 1 : 0))
  end

  def tree_at? x, y
    row = rows[y]
    row[x % row.length] == '#'
  end

  def self.from_string str
    x = new
    x.rows = str.split("\n")
    x
  end
end

class Array
  def product
    inject {|a,b| a*b}
  end
end


grid = Grid.from_string ARGF.read
results = [
  grid.slide(0,0,1,1),
  grid.slide(0,0,3,1),
  grid.slide(0,0,5,1),
  grid.slide(0,0,7,1),
  grid.slide(0,0,1,2),
]
p results
p results.product
