require_relative '../lib/file_utilities'

ACTUAL = (File.read('input_actual.txt')).split(/\n/)

def expand(image)
  image = image.dup.map(&:dup)

  rows_inserted = 0
  (0...image.size).each do |row_idx|
    offset_row = row_idx + rows_inserted
    unless image[offset_row].match?(/#/)
      image.insert(offset_row, image[offset_row].dup)
      rows_inserted += 1
    end
  end

  cols_inserted = 0
  (0...image[0].size).each do |col_idx|
    offset_col = col_idx + cols_inserted
    if image.none? { |row| row[offset_col].match(/#/) }
      image.map! { |row| row.insert(offset_col, '.') }
      cols_inserted += 1
    end
  end

  image
end

def scan_x_y_coord_lists(input)
  y = []
  x = []
  input.each_with_index do |row, index|
    indices = row.each_char.map.with_index do |char, idx|
      char == '#' ? idx : nil
    end
                 .compact
    x += indices
    y += [index] * indices.size
  end
  [x, y]
end

def _sum_shortest_lengths(x_coords, y_coords)
  x_coords.combination(2).sum { |a, b| (a - b).abs } +
    y_coords.combination(2).sum { |a, b| (a - b).abs }
end

def sum_shortest_lengths(x_coords, y_coords)
  x_coords.sort.map.with_index { |coord, index|
    coord * ((2 * index) - x_coords.size + 1)
  }.sum +
    y_coords.sort.map.with_index do |coord, index|
      coord * ((2 * index) - y_coords.size + 1)
    end.sum
end

def part_one(input)
  expanded = expand(input)
  x, y = scan_x_y_coord_lists(expanded)
  sum_shortest_lengths(x, y)
end

def find_empty_rows_cols(image)
  y = (0...image.size).reject { |row_idx| image[row_idx].match?('#') }
  x = (0...image[0].size).reject do |col_idx|
    image.any? do |row|
      row[col_idx] == '#'
    end
  end
  [x, y]
end

def apply_offset!(target, empties, empty_size: 1000000)
  target.map! do |galaxy_index|
    # number of empties to left/above
    empties_before = empties.count { |empty_index| empty_index < galaxy_index }
    # 1 becomes 1,000,000 i.e. +999,999
    offset = empty_size - 1
    galaxy_index + (offset * empties_before)
  end
end

def part_two(input)
  empty_x, empty_y = find_empty_rows_cols(input)
  x, y = scan_x_y_coord_lists(input)
  apply_offset!(x, empty_x)
  apply_offset!(y, empty_y)
  sum_shortest_lengths(x, y)
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
