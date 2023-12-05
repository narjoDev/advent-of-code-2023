require_relative 'solution'
require 'pry'

p(parse_first_line("seeds: 79 14 55 13") == [79, 14, 55, 13])
p(parse_map("seed-to-soil map:\n50 98 2\n52 50 1") == [
  'seed', { destination: 'soil', mapping:
  { 98 => 50, 99 => 51, 50 => 52 } }
])

# p(parse_input(EXAMPLE_ONE)) # wall of text

p(part_one(EXAMPLE_ONE) == 35)
# p(part_one(ACTUAL))
