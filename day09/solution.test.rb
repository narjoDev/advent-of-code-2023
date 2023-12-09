require_relative 'solution'

p(part_one(EXAMPLE_ONE) == 114)
p(part_one(ACTUAL).to_s == read_file('answer.txt').split("\n")[0])
