require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def parse_races(input)
  times, distances = input.map { |line| line.scan(/\d+/).map(&:to_i) }
  times.zip(distances)
end

def count_record_beaters(race)
  time, record = race
  (1...time).count do |hold_time|
    speed = hold_time
    travel_time = time - hold_time
    distance = speed * travel_time
    distance > record
  end
end

def part_one(input)
  parse_races(input)
    .map { |race| count_record_beaters(race) }
    .reduce(:*)
end

def part_two(input)
  time, record = input.map { |line| line.scan(/\d+/).join.to_i }
  count_record_beaters([time, record])
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
