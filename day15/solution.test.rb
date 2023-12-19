require_relative '../lib/file_utilities'
require_relative 'solution'
# require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')) # .split(/\n/)

# p([
#   (hash_value('rn=1') == 30),
#   (hash_value('cm-')  == 253),
#   (hash_value('qp=3') == 97)
# ].all?)

p(part_one(EXAMPLE_ONE) == 1320)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])

boxes = {
  0 => [['rn', 1], ['cm', 2]],
  1 => [['qp', 3]]
}
do_step('rn=2', boxes)
do_step('qp-', boxes)
p(boxes == { 0 => [['rn', 2], ['cm', 2]], 1 => [] })

p([
  (score_box(0, [['rn', 1], ['cm', 2]]) == 5),
  (score_box(3, [['ot', 7], ['ab', 5], ['pc', 6]]) == 140)
].all?)

p([
  (part_two(EXAMPLE_ONE) == 145),
  (part_two(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[1])
].all?)

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
