ACTUAL = (File.read('input_actual.txt'))

# Part One

def reflects?(pattern, index_after)
  first_half = pattern[...index_after].reverse
  second_half = pattern[index_after..]
  lesser_size = [first_half.size, second_half.size].min
  first_half.slice(0, lesser_size) == second_half.slice(0, lesser_size)
end

def score(pattern, forbidden_score: nil)
  (1...pattern.size).each do |index_after|
    next if index_after * 100 == forbidden_score
    return index_after * 100 if reflects?(pattern, index_after)
  end

  transposed = pattern.map(&:chars).transpose.map(&:join)
  (1...transposed.size).each do |index_after|
    next if index_after == forbidden_score
    return index_after if reflects?(transposed, index_after)
  end
  nil
end

def part_one(input)
  patterns = input.split("\n\n").map { |pattern| pattern.split("\n") }
  scores = patterns.map { |pattern| score(pattern) }
  scores.sum
end

# Part Two

def smudge_score(pattern)
  original_score = score(pattern)
  pattern.each_index do |row|
    pattern[row].each_char.with_index do |char, char_index|
      try_pattern = pattern.map(&:dup)
      other_char = '#.'.delete(char)
      try_pattern[row][char_index] = other_char
      try_score = score(try_pattern, forbidden_score: original_score)
      return try_score if try_score
    end
  end
end

def part_two(input)
  patterns = input.split("\n\n").map { |pattern| pattern.split("\n") }
  scores = patterns.map { |pattern| smudge_score(pattern) }
  scores.sum
end
