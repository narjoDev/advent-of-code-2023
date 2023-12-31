require_relative '../lib/file_utilities'
require_relative 'solution'
require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

grid_one = EXAMPLE_ONE.map(&:chars)
grid_two = EXAMPLE_TWO.map(&:chars)

# p(tilt_up(grid_one) == grid_two)
# p(load_of(grid_two) == 136)

# p(part_one(EXAMPLE_ONE) == 136)
# p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])

# Benchmark.bm(20) do |b|
#   b.report('spin 1') { spin(grid_one, 1) }
#   b.report('tilt example') { tilt_up(grid_one) }
#   b.report('part one actual') { part_one(ACTUAL) }
#   b.report('part two actual x1') { part_two(ACTUAL, 1) }
# end

p(part_two(ACTUAL, 300))

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
