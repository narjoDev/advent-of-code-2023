require_relative '../lib/file_utilities'
require_relative 'solution'
# require 'benchmark'

# Data

EXAMPLE_ONE = (File.read('example_one.txt'))
EXAMPLE_TWO = (File.read('example_two.txt'))

pattern_1, pattern_2 = EXAMPLE_ONE.split("\n\n").map do |pattern|
  pattern.split("\n")
end
pattern_1_rot = pattern_1.map(&:chars).transpose.map(&:join)

# Tests

p([
  (reflects?(pattern_1_rot, 4)  == false),
  (reflects?(pattern_1_rot, 5)  == true),
  (reflects?(pattern_1_rot, 6)  == false),
  (reflects?(pattern_2, 3) == false),
  (reflects?(pattern_2, 4) == true),
  (reflects?(pattern_2, 5) == false)
].all?)

p([
  (score(pattern_1) == 5),
  (score(pattern_2) == 400)
].all?)

p([
  (part_one(EXAMPLE_ONE) == 405),
  (part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
].all?)

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
