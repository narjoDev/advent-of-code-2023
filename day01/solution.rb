require_relative '../lib/file_utilities'

EXAMPLE = lines_of(read_file('input_example.txt'))
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
  digits = Array(0..9).map(&:to_s)
  including_digits = digit_words + digits
  pattern = Regexp.new("(?=(#{including_digits.join('|')}))")
  # pattern = /(?=(zero|one|two|three|four|five|six|seven|eight|nine|0|1|2|3|4|5|6|7|8|9))/

  all_matches = line.scan(pattern).flatten
  keep = [all_matches.first, all_matches.last]
  keep.map! { |match| digit_words.index(match) || match }

  keep.join.to_i
end

def part_two(input)
  input.map { |line| recover_including_words(line) }
       .sum
end

answer_one = part_one(ACTUAL)
overwrite('output.txt', "#{answer_one}\n")
answer_two = part_two(ACTUAL)
append_write('output.txt', "#{answer_two}\n")
