require_relative '../lib/file_utilities'

EXAMPLE_ONE = read_file('example_one.txt')
EXAMPLE_TWO = read_file('example_two.txt')
ACTUAL = read_file('input_actual.txt')

def parse(input)
  directions, network = input.split("\n\n")
  network = network.split("\n").to_h do |line|
    node, left_right = line.split(' = ')
    left_right = left_right.delete('()').split(', ')
    [node, left_right]
  end
  [directions, network]
end

def part_one(input)
  directions, network = parse(input)
  steps = 0

  here = 'AAA'
  directions.each_char.cycle do |go|
    here = network[here]['LR'.index(go)]
    steps += 1
    return steps if here == 'ZZZ'
  end
end

def part_two(input)
  input
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
