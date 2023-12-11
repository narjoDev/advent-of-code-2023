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
                 .reject(&:nil?)
    x += indices
    y += [index] * indices.size
  end
  [x, y]
end

def sum_shortest_lengths(x_coords, y_coords)
  x_coords.combination(2).sum { |a, b| (a - b).abs } +
    y_coords.combination(2).sum { |a, b| (a - b).abs }
end

def part_one(input)
  expanded = expand(input)
  x, y = scan_x_y_coord_lists(expanded)
  sum_shortest_lengths(x, y)
end

def part_two(input)
  input
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
