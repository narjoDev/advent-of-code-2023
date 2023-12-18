require_relative 'solution'
require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

# p(parse_input('???.### 1,1,3') == ['???.###', [1, 1, 3]])

# p(correct_groups?('#.#.###', [1, 1, 3]) == true)
# p(correct_groups?('..#.###', [1, 1, 3]) == false)
# p(correct_groups?('###.#.#', [1, 1, 3]) == false)
# p(correct_groups?('.#....#...###.', [1, 1, 3]) == true)

# p((row_possibilities('???.###', [1, 1, 3]) == 1) &&
#   (row_possibilities(".??..??...?##.", [1, 1, 3]) == 4) &&
#   (row_possibilities('?#?#?#?#?#?#?#?', [1, 3, 1, 6]) == 1))

# (Benchmark.bm do |x|
#    x.report('p1 ex1') { p(part_one(EXAMPLE_ONE) == 21) }
#    x.report('p1 actual') do
#      p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
#    end
#  end)

p(unfold('.# 1') == '.#?.#?.#?.#?.# 1,1,1,1,1')
p(unfold('???.### 1,1,3') == '???.###????.###????.###????.###????.### 1,1,3,1,1,3,1,1,3,1,1,3,1,1,3')

puts(Benchmark.measure { p(part_two(EXAMPLE_ONE) == 525152) })
