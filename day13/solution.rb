ACTUAL = (File.read('input_actual.txt'))

# Part One

def reflects?(pattern, index_after)
  first_half = pattern[...index_after].reverse
  second_half = pattern[index_after..]
  lesser_size = [first_half.size, second_half.size].min
  first_half.slice(0, lesser_size) == second_half.slice(0, lesser_size)
end

def score(pattern)
  (1...pattern.size).each do |index_after|
    return index_after * 100 if reflects?(pattern, index_after)
  end

  transposed = pattern.map(&:chars).transpose.map(&:join)
  (1...transposed.size).each do |index_after|
    return index_after if reflects?(transposed, index_after)
  end
  raise 'No reflection?'
end

def part_one(input)
  patterns = input.split("\n\n").map { |pattern| pattern.split("\n") }
  scores = patterns.map { |pattern| score(pattern) }
  scores.sum
end

# Part Two

def part_two(input)
  input
end
