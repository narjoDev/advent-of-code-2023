require_relative '../lib/file_utilities'

EXAMPLE_ONE = (read_file('example_one.txt'))
EXAMPLE_TWO = (read_file('example_two.txt'))
ACTUAL = (read_file('input_actual.txt'))

def parse_first_line(line)
  line.scan(/\d+/).map(&:to_i)
end

def parse_map(line)
  lines = line.split(/\n/)
  heading = lines.shift
  source, destination = heading.split[0].split("-to-")

  mapping = {}
  lines.each do |range_str|
    to_number, from_number, range_size = range_str.split.map(&:to_i)
    offset = to_number - from_number
    range = (from_number...from_number + range_size)
    mapping[range] = offset
  end
  [source, { destination:, mapping: }]
end

def parse_input(input)
  input = input.split(/\n\n/)
  seeds = parse_first_line(input.shift)
  maps = input.map { |line| parse_map(line) }
              .to_h
  [seeds, maps]
end

def fetch_destination(source, number, maps)
  maps[source][:mapping].each do |range, offset|
    return number + offset if range.include?(number)
  end
  number
end

def trace_route(seed_number, maps)
  number = seed_number
  maps.keys.each do |source|
    number = fetch_destination(source, number, maps)
  end
  number
end

def part_one(input)
  seeds, maps = parse_input(input)
  seed_locations = seeds.map { |seed_number| trace_route(seed_number, maps) }
  seed_locations.min
end

def part_two(input)
  input
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
