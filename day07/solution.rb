require_relative '../lib/file_utilities'
require 'pry'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

TYPES = %w(high one two three full four five)
CARDS = %w(2 3 4 5 6 7 8 9 T J Q K A)

def parse_input(lines)
  lines.map do |line|
    cards, bid = line.split
    bid = bid.to_i
    type = type_of(cards)
    { cards:, bid:, type: }
  end
end

def type_of(cards)
  card_counts = cards.each_char.tally.values.sort.join
  case card_counts
  when '5' then 'five'
  when '14' then 'four'
  when '23' then 'full'
  when '113' then 'three'
  when '122' then 'two'
  when '1112' then 'one'
  else 'high'
  end
end

def compare_hands(hand1, hand2)
  if hand1[:type] == hand2[:type]
    (0...hand1[:cards].size).each do |index|
      card1 = hand1[:cards][index]
      card2 = hand2[:cards][index]
      comparison = CARDS.index(card1) <=> CARDS.index(card2)
      return comparison unless comparison.zero?
    end
    0 # requires duplicate hands
  else
    TYPES.index(hand1[:type]) <=> TYPES.index(hand2[:type])
  end
end

def total_winnings(sorted_hands)
  sorted_hands.map.with_index do |hand, index|
    (hand[:bid] * (index + 1))
  end.sum
end

def part_one(input)
  hands = parse_input(input)
          .sort { |a, b| compare_hands(a, b) }
  total_winnings(hands)
end

def part_two(input)
  input
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
