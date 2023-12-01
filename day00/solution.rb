require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def part_one(_input)
  'foo'
end

def part_two(_input)
  'bar'
end

answer_one = part_one(ACTUAL)
answer_two = part_two(ACTUAL)
overwrite('output.txt', answer_one + "\n")
append_write('output.txt', answer_two + "\n")
