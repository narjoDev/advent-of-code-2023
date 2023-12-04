require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def parse_card(line)
  card, numbers = line.split(':')
  id = card.match(/\d+/)[0].to_i
  winning, owned = numbers.split('|')
                          .map { |str_of_nums| str_of_nums.scan(/\d+/) }
                          .map { |arr_of_nums| arr_of_nums.map(&:to_i) }
  { id:, winning:, owned: }
end

def owned_winning_numbers(card)
  card[:owned].select { |num| card[:winning].include? num }
end

def point_value(owned_winning_cards)
  return 0 if owned_winning_cards.empty?
  2**(owned_winning_cards.size - 1)
end

def part_one(input)
  cards = input.map { |line| parse_card(line) }
  owned_winning = cards.map { |card| owned_winning_numbers(card) }
  card_points = owned_winning.map { |numbers| point_value(numbers) }
  card_points.sum
end

def part_two(input)
  input
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
