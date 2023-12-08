require_relative 'solution'
require 'pry'

# p(parse_first_line("seeds: 79 14 55 13") == [79, 14, 55, 13])
# p(parse_map("seed-to-soil map:\n50 98 2\n52 50 1") == [
#   'seed', { destination: 'soil', mapping:
#   { (98...100) => -48, (50...51) => 2 } }
# ])

# p(parse_input(EXAMPLE_ONE)) # wall of text

p(part_one(EXAMPLE_ONE) == 35)
p(part_one(ACTUAL) == 214922730)

# # notice unsorted
# p(parse_seed_ranges("seeds: 79 14 55 13") == [(79...93), (55...68)])
# p(parse_simpler_map("seed-to-soil map:\n50 98 2\n52 50 1") == {
#   (98...100) => -48, (50...51) => 2
# })

p(range_to_next_stage((1...10),
                      { (2...5) => 10,
                        (6...8) => 4 }).sort_by(&:min) == [
                          (1...2), (5...6), (8...10),
                          (10...12), (12...15)
                        ])

p(part_two(EXAMPLE_ONE) == 46)
p(part_two(ACTUAL) == 148041808)
