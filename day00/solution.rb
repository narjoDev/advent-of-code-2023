require_relative '../lib/file_utilities'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)
ACTUAL = (File.read('input_actual.txt')).split(/\n/)

def part_one(input)
  input
end

def part_two(input)
  input
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
