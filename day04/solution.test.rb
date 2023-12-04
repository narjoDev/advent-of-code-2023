require_relative 'solution'

# p(
#   parse_card(EXAMPLE_ONE[0]) == { id: 1,
#                                   winning: [41, 48, 83, 86, 17],
#                                   owned: [83, 86, 6, 31, 17, 9, 48, 53] }
# )
# p(
#   owned_winning_numbers({ id: 1,
#                           winning: [41, 48, 83, 86, 17],
#                           owned: [83, 86, 6, 31, 17, 9, 48,
#                                   53] }).sort == [48, 83, 17, 86].sort
# )
# p(point_value([]) == 0)
# p(point_value([48]) == 1)
# p(point_value([48, 83, 17, 86]) == 8)
p(part_one(EXAMPLE_ONE) == 13)
p(part_one(ACTUAL) == 24175)

# p(owned_and_instances({ id: 1,
#                         winning: [41, 48, 83, 86, 17],
#                         owned: [83, 86, 6, 31, 17, 9, 48,
#                                 53] }) == { winning_owned: 4, instances: 1 })

p(part_two(EXAMPLE_ONE) == 30)
p(part_two(ACTUAL) == 18846301)
