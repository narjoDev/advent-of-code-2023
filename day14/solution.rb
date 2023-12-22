ACTUAL = (File.read('input_actual.txt')).split(/\n/)

# Part One

ROUND = 'O'
CUBE = '#'
EMPTY = '.'

def tilt_up(grid)
  grid = grid.dup.map(&:dup)

  moved = true
  while moved
    moved = false

    grid[..-2].each_with_index do |row, row_index|
      row.each_with_index do |char, col_index|
        if char == EMPTY && grid[row_index + 1][col_index] == ROUND
          grid[row_index][col_index] = ROUND
          grid[row_index + 1][col_index] = EMPTY
          moved = true
        end
      end
    end
  end
  grid
end

def load_of(grid)
  grid.each_with_index.reduce(0) do |sum, (row, index)|
    multiplier = grid.size - index
    sum + (row.count(ROUND) * multiplier)
  end
end

def part_one(input)
  grid = input.map(&:chars)
  grid = tilt_up(grid)
  load_of(grid)
end

# Part Two

def part_two(input)
  input
end
