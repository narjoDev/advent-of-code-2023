require_relative '../lib/file_utilities'

EXAMPLE_ONE = lines_of(read_file('example_one.txt'))
EXAMPLE_TWO = lines_of(read_file('example_two.txt'))
ACTUAL = lines_of(read_file('input_actual.txt'))

SYMBOL_PATTERN = /[^\d\.]/

def adjacent_symbol?(input, digit_row_index,
                     first_digit_index, last_digit_index)
  window_begin = [digit_row_index - 1, 0].max
  window_end = [digit_row_index + 1, input.size - 1].min
  (window_begin..window_end).each do |row_to_search_index|
    row = input[row_to_search_index]
    left = [first_digit_index - 1, 0].max
    right = [last_digit_index + 1, row.size - 1].min
    return true if row[left..right].match?(SYMBOL_PATTERN)
  end
  false
end

def part_one(input)
  part_numbers = []
  (0...input.size).each do |row_index|
    row = input[row_index]
    first_digit_index = 0
    while first_digit_index < row.size
      if row[first_digit_index].match(/\D/)
        first_digit_index += 1
      else
        last_digit_index = first_digit_index
        last_digit_index += 1 until (last_digit_index + 1) >= row.size || row[last_digit_index + 1].match(/\D/)
        number = row[first_digit_index..last_digit_index].to_i
        part_numbers << number if adjacent_symbol?(input, row_index,
                                                   first_digit_index, last_digit_index)
        first_digit_index = last_digit_index + 2
      end
    end
  end
  part_numbers.sum
end

def register_adjacent_stars!(input, digit_row_index, first_digit_index,
                             last_digit_index, possible_gears)
  part_number = input[digit_row_index][first_digit_index..last_digit_index].to_i

  window_begin = [digit_row_index - 1, 0].max
  window_end = [digit_row_index + 1, input.size - 1].min

  (window_begin..window_end).each do |row_to_search_index|
    row = input[row_to_search_index]
    left = [first_digit_index - 1, 0].max
    right = [last_digit_index + 1, row.size - 1].min

    (left..right).each do |char_to_search_index|
      char = row[char_to_search_index]
      next unless char.match?(/\*/)

      star_coordinates = [row_to_search_index, char_to_search_index]
      if possible_gears.key?(star_coordinates)
        possible_gears[star_coordinates] << part_number
      else
        possible_gears[star_coordinates] = [part_number]
      end
    end
  end
  nil
end

def part_two(input)
  possible_gears = {}

  (0...input.size).each do |row_index|
    row = input[row_index]
    first_digit_index = 0
    while first_digit_index < row.size
      if row[first_digit_index].match(/\D/)
        first_digit_index += 1
      else
        last_digit_index = first_digit_index
        last_digit_index += 1 until (last_digit_index + 1) >= row.size || row[last_digit_index + 1].match(/\D/)

        if adjacent_symbol?(input, row_index, first_digit_index,
                            last_digit_index)
          register_adjacent_stars!(input, row_index, first_digit_index,
                                   last_digit_index, possible_gears)
        end
        first_digit_index = last_digit_index + 2
      end
    end
  end

  possible_gears
    .select { |_coordinates, adjacent_parts| adjacent_parts.size == 2 }
    .map { |_coordinates, adjacent_parts| adjacent_parts.reduce(:*) }
    .sum
end

overwrite('output.txt', "#{part_one(ACTUAL)}\n")
append_write('output.txt', "#{part_two(ACTUAL)}\n")
