#!/usr/bin/env ruby

class Instruction
  def initialize instruction, arg
    @instruction = instruction
    @arg = arg
  end

  def flip_instruction
    if @instruction == 'jmp'
      @instruction = 'nop'
    elsif @instruction == 'nop'
      @instruction = 'jmp'
    end
  end

  def run counter, acc
    if @instruction == 'nop'
      [counter + 1, acc]
    elsif @instruction == 'jmp'
      [counter + @arg, acc]
    elsif @instruction == 'acc'
      [counter + 1, acc + @arg]
    else
      raise StandardError.new("Unknown command #{@instruction.inspect}.")
    end
  end

  def self.from_line line
    instruction, arg = line.split
    new instruction, arg.to_i
  end
end

class Program
  def initialize instructions
    @instructions = instructions
  end

  def run
    program_counter = 0
    acc = 0
    result = :halts
    visited = []
    while true do
      break if program_counter == @instructions.length
      instruction = @instructions[program_counter]
      if visited.index(program_counter)
        result = :inf
        break
      end
      visited << program_counter
      program_counter, acc = *instruction.run(program_counter, acc)
    end
    [acc, result]
  end

  def check_for_cosmic_rays
    @instructions.each do |i|
      i.flip_instruction
      result = run
      return result if result[1] == :halts
      i.flip_instruction
    end
  end
end

instructions = ARGF.read.split("\n").map { |l| Instruction.from_line l }
program = Program.new instructions
p program.check_for_cosmic_rays
