require_relative 'solution'

p(parse(EXAMPLE_TWO) == ['LLR',
                         {
                           'AAA' => ['BBB', 'BBB'],
                           'BBB' => ['AAA', 'ZZZ'],
                           'ZZZ' => ['ZZZ', 'ZZZ']
                         }])

p(part_one(EXAMPLE_ONE)  == 2)
p(part_one(EXAMPLE_TWO)  == 6)
p(part_one(ACTUAL).to_s == read_file('answer.txt').split("\n")[0])
