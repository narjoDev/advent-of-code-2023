require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

def parse_card(line)
  card, numbers = line.split(':')
  id = card.match(/\d+/)[0].to_i
  winning, owned = numbers.split('|')
                          .map { |str_of_nums| str_of_nums.scan(/\d+/) }
                          .map { |arr_of_nums| arr_of_nums.map(&:to_i) }
  { id:, winning:, owned: }
end

def select_owned_winning_numbers(card)
  card[:owned].select { |num| card[:winning].include? num }
end

def point_value(numbers)
  numbers.empty? ? 0 : 2**(numbers.size - 1)
end

def part_one(input)
  input.map { |line| parse_card(line) }
       .map { |card| select_owned_winning_numbers(card) }
       .map { |numbers| point_value(numbers) }
       .sum
end

def simplify_card(card)
  { num_winning_owned: select_owned_winning_numbers(card).size, instances: 1 }
end

def part_two(input)
  cards = input.map { |line| simplify_card(parse_card(line)) }

  cards.each_with_index do |card, index|
    1.upto(card[:num_winning_owned]) do |offset|
      target_index = index + offset
      cards[target_index][:instances] += card[:instances]
    end
  end

  cards.sum { |card| card[:instances] }
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
