require_relative '../lib/file_utilities'

ACTUAL = (File.read('input_actual.txt')).split(/\n/)

# Part One

def part_one(input)
  input
end

# Part Two

def part_two(input)
  input
end

# Output

write_parts = 0

overwrite('output.txt', "#{part_one(ACTUAL)}\n") if write_parts.nonzero?
append_write('output.txt', "#{part_two(ACTUAL)}\n") if write_parts == 2
