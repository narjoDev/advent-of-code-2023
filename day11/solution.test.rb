require_relative 'solution'
require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

simple_map = %w(#.. ..# #..)

# p(expand(EXAMPLE_ONE) == EXAMPLE_TWO)
# p(scan_x_y_coord_lists(simple_map).map(&:sort) == [[0, 0, 2], [0, 1, 2]])
p(sum_shortest_lengths([0, 0, 2], [0, 1, 2]) == 8)
p(sum_shortest_lengths([0, 2, 0], [2, 0, 1]) == 8)

x, y = scan_x_y_coord_lists(expand(ACTUAL))
Benchmark.bm(20) do |bench|
  bench.report("all pairs:") { _sum_shortest_lengths(x, y) }
  bench.report("sort then each once:") { sum_shortest_lengths(x, y) }
end

p(part_one(EXAMPLE_ONE) == 374)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])

p(find_empty_rows_cols(simple_map) == [[1], []])
p(part_two(EXAMPLE_ONE) == 82000210)
p(part_two(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[1])
