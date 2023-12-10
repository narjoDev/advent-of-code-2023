EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)
ACTUAL = (File.read('input_actual.txt')).split(/\n/)

CONNECTIONS =
  { '|' => ['north', 'south'],
    '-' => ['east', 'west'],
    'L' => ['north', 'east'],
    'J' => ['north', 'west'],
    '7' => ['south', 'west'],
    'F' => ['south', 'east'],
    '.' => [] }

OPPOSITES =
  {
    'north' => 'south',
    'south' => 'north',
    'east' => 'west',
    'west' => 'east'
  }

def locate_start(grid)
  grid.each_index do |y|
    x = grid[y].index('S')
    return { x:, y: } if x
  end
end

def get_start_direction(grid, start_coordinates)
  start_x, start_y = start_coordinates.fetch_values(:x, :y)
  if start_y.nonzero?
    north_shape = grid[start_y - 1][start_x]
    return 'north' if CONNECTIONS[north_shape].include? 'south'
  end
  if start_x.nonzero?
    west_shape = grid[start_y][start_x - 1]
    return 'west' if CONNECTIONS[west_shape].include? 'east'
  end
  if start_y < grid.size - 1
    south_shape = grid[start_y + 1][start_x]
    return 'south' if CONNECTIONS[south_shape].include? 'north'
  end
  if  start_x < grid[start_y].size - 1
    east_shape = grid[start_y][start_x + 1]
    return 'east' if CONNECTIONS[east_shape].include? 'west'
  end
  nil # bug or invalid input
end

def move!(coordinates, direction)
  case direction
  when 'north' then coordinates[:y] -= 1
  when 'south' then coordinates[:y] += 1
  when 'east' then coordinates[:x] += 1
  when 'west' then coordinates[:x] -= 1
  end
  coordinates
end

def length_to_farthest(grid, start_coordinates, starting_direction)
  location = start_coordinates.dup
  next_direction = starting_direction
  loop_length = 1

  loop do
    move!(location, next_direction)
    tile = grid[location[:y]][location[:x]]
    if tile == 'S'
      return loop_length / 2
    else
      came_from = OPPOSITES[next_direction]
      next_direction =
        CONNECTIONS[tile]
        .reject { |direction| direction == came_from }
        .first
      loop_length += 1
    end
  end
end

def part_one(grid)
  start_coordinates = locate_start(grid)
  next_direction = get_start_direction(grid, start_coordinates)
  length_to_farthest(grid, start_coordinates, next_direction)
end

def part_two(input)
  input
end

# overwrite('output.txt', "#{part_one(ACTUAL)}\n")
# append_write('output.txt', "#{part_two(ACTUAL)}\n")
