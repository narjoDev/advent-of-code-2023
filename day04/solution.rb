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

def owned_and_instances(card)
  { winning_owned: owned_winning_numbers(card).size, instances: 1 }
end

def part_two(input)
  cards = input.map { |line| owned_and_instances(parse_card(line)) }
  cards.each_with_index do |card, index|
    cards_to_increment = card[:winning_owned]
    increment = card[:instances]
    cards_to_increment.times do |offset|
      target_index = index + 1 + offset
      cards[target_index][:instances] += increment
    end
  end
  cards.map { |card| card[:instances] }
       .sum
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
