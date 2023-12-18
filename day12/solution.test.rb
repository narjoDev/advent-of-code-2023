require_relative 'solution'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

# p(parse_input('???.### 1,1,3') == ['???.###', [1, 1, 3]])

p(correct_groups?('#.#.###', [1, 1, 3]) == true)
p(correct_groups?('..#.###', [1, 1, 3]) == false)
p(correct_groups?('###.#.#', [1, 1, 3]) == false)
p(correct_groups?('.#....#...###.', [1, 1, 3]) == true)

# p(row_possibilities('???.###', [1, 1, 3]) == 1) &&
#   (row_possibilities(".??..??...?##.", [1, 1, 3]) == 4) &&
#   (row_possibilities('?#?#?#?#?#?#?#?', [1, 3, 1, 6]) == 1)

p(part_one(EXAMPLE_ONE) == 21)
