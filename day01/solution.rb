require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def recover_value(line)
  digits = line.scan(/\d/)
  (digits.first + digits.last).to_i
end

def part_one(input)
  calibration_values = input.map { |line| recover_value(line) }
  calibration_values.sum
end

def recover_including_words(line)
  digit_words = %w(zero one two three four five six seven eight nine)
  pattern = /(?=(zero|one|two|three|four|five|six|seven|eight|nine|\d))/

  matches = line.scan(pattern).flatten
  first_and_last = [matches.first, matches.last]
  first_and_last.map { |match| digit_words.index(match) || match }
                .join.to_i
end

def part_two(input)
  input.map { |line| recover_including_words(line) }
       .sum
end

answer_one = part_one(ACTUAL)
overwrite('output.txt', "#{answer_one}\n")
answer_two = part_two(ACTUAL)
append_write('output.txt', "#{answer_two}\n")
