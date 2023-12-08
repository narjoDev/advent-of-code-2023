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
  directions.each_char.cycle do |go|
    node = network[node]['LR'.index(go)]
    if history.include?(node)
      cycle = history[history.index(node)..]
      length = cycle.length
      steps_to_end_node = history.index { |x| x.end_with?('Z') }
      binding.pry
      return [length, steps_to_end_node]
    else
      history << node
    end
  end
end

def part_two(input)
  directions, network = parse(input)
  steps = 0

  here = network.keys.filter { |node| node.end_with?('A') }
  cycles = here.map { |node| find_cycle(node, directions, network) }
  p cycles
  # cycles.each do |cycle|
  #   cycle[:steps] = cycle[:steps_to_end_node]
  # end
  # steps_taken = cycles.map { |info| info[:steps_to_end_node] }
  until cycles.map(&:last).uniq.size == 1
    p cycles
    binding.pry
  end
  # p here
  # directions.each_char.cycle do |go|
  #   p go
  #   p network.fetch_values(*here)
  #   here = here.map { |node| network[node]['LR'.index(go)] }
  #   p here
  #   steps += 1
  #   binding.pry
  #   return steps if here.all? { |node| node.end_with?('Z') }
  # end
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
