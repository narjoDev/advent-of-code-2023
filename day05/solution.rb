require_relative '../lib/file_utilities'
require_relative '../lib/range_operations'
require 'pry'

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

def parse_seed_ranges(line)
  numbers = line.split(':')[1].split.map(&:to_i)
  range_mins, lengths = numbers.partition.with_index { |_, i| i.even? }
  range_mins.zip(lengths).map do |(min, length)|
    (min...min + length)
  end
end

def parse_simpler_map(map_line)
  range_lines = map_line.split("\n")[1..]
                        .map { |line| line.split.map(&:to_i) }
  range_lines.to_h do |(to_number, from_number, range_size)|
    offset = to_number - from_number
    range = (from_number...from_number + range_size)
    [range, offset]
  end
end

def range_to_next_stage(range, mapping)
  conversion_queue = [range]
  converted_ranges = []

  mapping.each do |source_range, offset|
    next_queue = []
    conversion_queue.each do |range_to_convert|
      intersect = intersection(range_to_convert, source_range)
      if intersect
        converted = (intersect.min + offset..intersect.max + offset)
        converted = force_exclusive(converted) if range_to_convert.exclude_end?
        converted_ranges << converted
        next_queue += difference(range_to_convert, intersect)
      else
        next_queue << range_to_convert
      end
    end
    conversion_queue = next_queue
  end

  # anything left in queue stays same number
  converted_ranges + conversion_queue
end

def part_two(input)
  seed_input, *map_input = input.split(/\n\n/)
  ranges = parse_seed_ranges(seed_input)
  maps = map_input.map { |line| parse_simpler_map(line) }

  maps.each do |stage|
    ranges.map! { |range| range_to_next_stage(range, stage) }
          .flatten!
          .sort_by!(&:min)
    ranges = merge_many(ranges)
  end
  ranges.first.min
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
