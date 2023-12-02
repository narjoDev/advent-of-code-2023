require_relative 'solution'

line_1 = 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'
game_1 = [1, { "red" => 4, "green" => 2, "blue" => 6 }]

line_3 = 'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red'
game_3 = [3, { "red" => 20, "green" => 13, "blue" => 6 }]

p(parse_game(line_1) == game_1)

p(parse_game(line_3) == game_3)

p(possible_from_bag?(game_1, HYPOTHETICAL_BAG) == true)
p(possible_from_bag?(game_3, HYPOTHETICAL_BAG) == false)
p part_one(EXAMPLE_ONE)
p(part_one(EXAMPLE_ONE) == 8)
p(part_one(ACTUAL) == 2563)
