require_relative '../lib/file_utilities'
require 'pry'

ACTUAL = (File.read('input_actual.txt')).split(/\n/)

def parse_input(line)
  row, sizes = line.split
  [row, sizes.split(',').map(&:to_i)]
end

def correct_groups?(row, sizes)
  row.split(/\.+/).reject(&:empty?).map(&:size) == sizes
end

def row_possibilities(row, sizes)
  unknown = row.count('?')
  total_damaged = sizes.sum
  known_damaged = row.count('#')
  unknown_damaged = total_damaged - known_damaged
  unknown_operational = unknown - unknown_damaged

  springs = []
  unknown_damaged.times { springs << '#' }
  unknown_operational.times { springs << '.' }

  springs.permutation.uniq.count do |ordering|
    try_row = row.dup
    try_row.sub!('?', ordering.shift) until ordering.empty?
    correct_groups?(try_row, sizes)
  end
end

def part_one(input)
  lines = input.map { |line| parse_input(line) }
  line_possibilities = lines.map { |line| row_possibilities(*line) }
  # binding.pry
  line_possibilities.sum
end

def part_two(input)
  input
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
