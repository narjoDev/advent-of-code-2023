require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def part_one(input)
  input
end

def part_two(input)
  input
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
