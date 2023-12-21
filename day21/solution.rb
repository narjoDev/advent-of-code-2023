ACTUAL = (File.read('input_actual.txt')).split(/\n/)

# Part One

ROCK = '#'
GARDEN = '.'
START = 'S'
FOOTPRINT = 'O'
ADJ_REGEX = "#{START}|#{FOOTPRINT}"

def adjacent?(grid, row, col)
  [
    (row > 0) && (grid[row - 1][col].match?(ADJ_REGEX)),
    (col > 0) && (grid[row][col - 1].match?(ADJ_REGEX)),
    (col < grid[row].size - 1) && (grid[row][col + 1].match?(ADJ_REGEX)),
    (row < grid.size - 1) && (grid[row + 1][col].match?(ADJ_REGEX))
  ].any?
end

def step(grid, steps = 1)
  steps.times do
    next_grid = grid.map.with_index do |row, row_index|
      row.each_char.map.with_index do |char, char_index|
        case char
        when ROCK then ROCK
        when START, FOOTPRINT then GARDEN
        when GARDEN then if adjacent?(grid, row_index,
                                      char_index)
                           FOOTPRINT
                         else
                           GARDEN
                         end
        end
      end.join
    end
    grid = next_grid
  end
  grid
end

def part_one(input, steps = 64)
  step(input, steps).join.count(FOOTPRINT)
end

# Part Two

def part_two(input)
  input
end
