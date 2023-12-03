require_relative 'solution'

p(part_one(EXAMPLE_ONE) == 4361)
p(part_one(ACTUAL))

dummy_possible_gears = {}
register_adjacent_stars!(EXAMPLE_ONE, 0, 0, 2, dummy_possible_gears)
p(dummy_possible_gears == { [1, 3] => [467] })
register_adjacent_stars!(EXAMPLE_ONE, 2, 2, 3, dummy_possible_gears)
p(dummy_possible_gears == { [1, 3] => [467, 35] })

p(part_two(EXAMPLE_ONE) == 467835)
