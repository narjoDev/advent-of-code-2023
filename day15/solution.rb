ACTUAL = (File.read('input_actual.txt')) # .split(/\n/)

# Part One

def hash_value(str)
  str.each_char.reduce(0) do |value, char|
    ((value + char.ord) * 17) % 256
  end
end

def part_one(input)
  input.split(',').sum { |step| hash_value(step) }
end

# Part Two

def part_two(input)
  input
end
