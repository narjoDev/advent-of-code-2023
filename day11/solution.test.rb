require_relative 'solution'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

simple_map = %w(#.. ..# #..)

p(expand(EXAMPLE_ONE) == EXAMPLE_TWO)
p(scan_x_y_coord_lists(simple_map).map(&:sort) == [[0, 0, 2], [0, 1, 2]])
p(sum_shortest_lengths([0, 0, 2], [0, 1, 2]) == 8)

p(part_one(EXAMPLE_ONE) == 374)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
