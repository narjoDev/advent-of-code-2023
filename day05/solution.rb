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
  lines.each do |range|
    to_number, from_number, range_size = range.split.map(&:to_i)
    range_size.times do |offset|
      mapping[from_number + offset] = to_number + offset
    end
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
  maps[source][:mapping].fetch(number, number)
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

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
