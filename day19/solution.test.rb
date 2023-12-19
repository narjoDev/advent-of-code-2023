require_relative '../lib/file_utilities'
require_relative 'solution'
# require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt'))
EXAMPLE_TWO = (File.read('example_two.txt'))

# p(parse_input(EXAMPLE_ONE))

p([
  (part_one(EXAMPLE_ONE) == 19114),
  (part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
].all?)

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
