require_relative '../lib/file_utilities'
require_relative 'solution'
# require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
AFTER_SIX = (File.read('example_one_6.txt')).split(/\n/)
# EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

test_grid_1 = [
  'O..',
  '...',
  '..O'
]

p([
  (adjacent?(test_grid_1, 0, 1) == true),
  (adjacent?(test_grid_1, 0, 2) == false),
  (adjacent?(test_grid_1, 1, 0) == true),
  (adjacent?(test_grid_1, 1, 1) == false),
  (adjacent?(test_grid_1, 1, 2) == true),
  (adjacent?(test_grid_1, 2, 0) == false),
  (adjacent?(test_grid_1, 2, 1) == true)
].all?)

p(step(EXAMPLE_ONE, 6) == AFTER_SIX)

p(part_one(EXAMPLE_ONE, 6) == 16)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
