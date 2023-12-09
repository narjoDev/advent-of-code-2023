require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def parse_input(lines)
  lines.map(&:split).map { |line| line.map(&:to_i) }
end

def differences_between(sequence)
  (1...sequence.size).map do |index|
    sequence[index] - sequence[index - 1]
  end
end

def extrapolate_next(history)
  sequences = [history]
  until sequences.last.all?(0)
    sequences << differences_between(sequences.last)
  end
  sequences.sum(&:last)
end

def part_one(input)
  histories = parse_input(input)
  histories.map { |history| extrapolate_next(history) }
           .sum
end

def extrapolate_previous(history)
  sequences = [history]
  until sequences.last.all?(0)
    sequences << differences_between(sequences.last)
  end
  sequences.map(&:first)
           .reverse
           .reduce { |difference, num| num - difference }
end

def part_two(input)
  histories = parse_input(input)
  histories.map { |history| extrapolate_previous(history) }
           .sum
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
