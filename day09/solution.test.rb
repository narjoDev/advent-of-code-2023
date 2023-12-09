require_relative 'solution'

p(part_one(EXAMPLE_ONE) == 114)
p(part_one(ACTUAL).to_s == read_file('answer.txt').split("\n")[0])

p(extrapolate_previous([10, 13, 16, 21, 30, 45]) == 5)
p(part_two(EXAMPLE_ONE) == 2)
p(part_two(ACTUAL).to_s == read_file('answer.txt').split("\n")[1])
