#!/usr/bin/env ruby

class Seat
  attr_accessor :row, :seat

  def seat_id
    row * 8 + seat
  end

  def to_s
    "#{row}, #{seat} => #{seat_id}"
  end

  def self.from_code c
    x = new
    x.row = c[0 .. 7].gsub('B', '1').gsub('F', '0').to_i(2)
    x.seat = c[7 .. 10].gsub('L', '0').gsub('R', '1').to_i(2)
    x
  end
end

seats = ARGF.read.split("\n").map { |x| Seat.from_code x }
puts seats.sort_by(&:seat_id).last
p((1 .. seats.sort_by(&:seat_id).last.seat_id).to_a - seats.map(&:seat_id))
