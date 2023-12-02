require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

COLORS = %w(red green blue)
HYPOTHETICAL_BAG = { 'red' => 12, 'green' => 13, 'blue' => 14 }

def parse_game(line)
  id = line.match(/(\d+):/).captures[0].to_i
  max_colors = Hash.new(0)
  handfuls = line.split(':')[1]
  COLORS.each do |color|
    pattern = Regexp.new("(\\d+) #{color}")
    quantities_pulled = handfuls.scan(pattern).flatten.map(&:to_i)
    max_colors[color] = quantities_pulled.max
  end
  [id, max_colors]
end

def possible_from_bag?(game, bag)
  bag.each { |color, number| return false if game[1][color] > number }
  true
end

def part_one(input)
  games = input.map { |line| parse_game(line) }
  possible = games.select { |game| possible_from_bag?(game, HYPOTHETICAL_BAG) }
  ids = possible.map(&:first)
  ids.sum
end

def power_of(game)
  game[1].values.reduce(:*)
end

def part_two(input)
  powers = input.map { |line| power_of(parse_game(line)) }
  powers.sum
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
