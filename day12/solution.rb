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
  unknown_damaged = sizes.sum - row.count('#')
  unknown_indices = (0...row.size).select { |index| row[index] == '?' }

  unknown_indices.combination(unknown_damaged).count do |damage_indices|
    try_row = row.dup
    damage_indices.each { |idx| try_row[idx] = '#' }
    try_row.gsub!('?', '.')
    correct_groups?(try_row, sizes)
  end
end

def part_one(input)
  lines = input.map { |line| parse_input(line) }
  line_possibilities = lines.map { |line| row_possibilities(*line) }
  line_possibilities.sum
end

def unfold(line_str)
  row, sizes = line_str.split
  row = ([row] * 5).join('?')
  sizes = ([sizes] * 5).join(',')
  "#{row} #{sizes}"
end

def part_two(input)
  lines = input.map { |line| parse_input(unfold(line)) }
  line_possibilities = lines.map.with_index do |line, idx|
    puts idx
    row_possibilities(*line)
  end
  line_possibilities.sum
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
