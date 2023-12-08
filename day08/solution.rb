require_relative '../lib/file_utilities'
require 'pry'

EXAMPLE_ONE = read_file('example_one.txt')
EXAMPLE_TWO = read_file('example_two.txt')
EXAMPLE_THREE = read_file('example_three.txt')
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

def find_cycle(node, directions, network)
  history = [node]
  end_node = nil

  directions.each_char.cycle do |go|
    node = network[node]['LR'.index(go)]
    if end_node.nil? && node.end_with?('Z')
      end_node = node
      history << node
    elsif node == end_node
      # second occurence
      first_end_encounter = history.index(end_node)
      cycle = history[first_end_encounter..]
      cycle_length = cycle.size
      return [first_end_encounter, cycle_length]
    else
      history << node
    end
  end
end

def _part_two(input)
  directions, network = parse(input)
  here = network.keys.filter { |node| node.end_with?('A') }
  cycles = here.map { |node| find_cycle(node, directions, network) }
  # Make a billion assumptions about the problem
  cycles.map(&:first).reduce(&:lcm)
end

# Make possibly even more assumptions
def part_two(input)
  directions, network = parse(input)
  paths = network.keys.filter { |node| node.end_with?('A') }

  steps_to_ends = paths.map do |node|
    steps = 0
    directions.each_char.cycle do |go|
      node = network[node]['LR'.index(go)]
      steps += 1
      break steps if node.end_with?('Z')
    end
  end
  steps_to_ends.reduce(&:lcm)
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
