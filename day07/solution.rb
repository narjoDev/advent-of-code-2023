require_relative '../lib/file_utilities'
require 'pry'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

TYPES = %w(high one two three full four five)
CARDS = %w(2 3 4 5 6 7 8 9 T J Q K A)

WILD_ORDER = %w(J 2 3 4 5 6 7 8 9 T Q K A)

def parse_input(lines, wild: false)
  lines.map do |line|
    cards, bid = line.split
    bid = bid.to_i
    type = wild ? wild_type_of(cards) : type_of(cards)
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

def wild_type_of(cards)
  return type_of(cards) unless cards.match?('J')
  jokerless_counts = cards.delete('J').each_char.tally.values.sort.join
  case jokerless_counts
  when /^\d?$/ then 'five'
  when /^1\d$/ then 'four'
  when '22' then 'full'
  when /^11(1|2)$/ then 'three'
  when '1111' then 'one'
  end
  # 'two' and 'high' cannot happen with any jokers in the hand

  # Alt method:
  # return 'five' if cards.chars.all?("J") # == 'JJJJJ'
  # highest_other = cards.delete('J').each_char.tally.max_by(&:last).first
  # type_of(cards.gsub("J", highest_other))
end

def compare_hands(hand1, hand2, wild: false)
  if hand1[:type] == hand2[:type]
    (0...hand1[:cards].size).each do |index|
      card1 = hand1[:cards][index]
      card2 = hand2[:cards][index]
      comparison = if wild
                     WILD_ORDER.index(card1) <=> WILD_ORDER.index(card2)
                   else
                     CARDS.index(card1) <=> CARDS.index(card2)
                   end
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
  hands = parse_input(input, wild: true)
          .sort { |a, b| compare_hands(a, b, wild: true) }
  total_winnings(hands)
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
