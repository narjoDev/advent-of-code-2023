require_relative '../lib/file_utilities'
require_relative 'solution'
# require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')) # .split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')) # .split(/\n/)

p([
  (hash_value('rn=1') == 30),
  (hash_value('cm-')  == 253),
  (hash_value('qp=3') == 97)
].all?)

p(part_one(EXAMPLE_ONE) == 1320)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
