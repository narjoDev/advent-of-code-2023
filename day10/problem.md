# Day 10

## Part One

### Problem

- two-dimensional grid of tiles
- contains ground and pipes
- some of the pipe forms a continuous loop
- we are given the starting position of an animal
  - but have to deduce what the shape of pipe there is
- navigate along the pipe to the point the farthest from the starting point
  - count based on distance through the pipe
- return distance to farthest point

### Examples

a square loop of pipe:

```
.....
.F-7.
.|.|.
.L-J.
.....
```

Note: 'S' will have exactly two connecting pipes, of the 2-4 adjacent

distance:

```
.....
.012.
.1.3.
.234.
.....
```

- The distance of the farthest point is half the length of the loop

### Data Structures

Some sort of hash mapping pipe characters to their destinations:

```
'|' => ['north', 'south']
'-' => ['east', 'west']
'L' => ['north', 'east']
'J' => ['north', 'west']
'7' => ['south', 'west']
'F' => ['south', 'east']
'.' => []
'S' => must deduce from surroundings
```

- Store directions as cardinals? x,y vectors?
```
x 0 1 2 ...

y 0
  1
  2
  .
  .
  .

Follows conventions and aligns with indices of input rows
x,y => grid[y][x]

north: y - 1
south: y + 1
west: x - 1
east: x + 1

coordinates {x: 12, y: 5}
move(north) => coordinates[:y] -= 1
```

### Algorithm

- High level strategy:
  - figure out the shape of the starting pipe
  - walk loop until we return to the beginning, counting length
  - divide length by two

- figuring out starting pipe
  - check left, right, above, below
    - if tile we check leads back where we came from, we connect there
    - technically, if we find a valid connection, we can just start crawling the pipe (we don't have to find the other one or label `S`)



```
SHAPE_DIRECTIONS hash, see above


locate_start:
  iterate through rows (y)
    iterate through chars (x)
      if char is S, return {x:, y:}


get_start_direction:
  for north, south, east, west:
    if direction in bounds:
      if connected opposite, return (i.e. if north has south connection, return north)


get_connections(coordinates)
  access hash


opposite(direction):
  ...


move!(location, direction)
  ...switch statement
  mutates and returns location coordinates hash


length_to_farthest:
  location {x:, y:} (begin at S)
  next_direction: start_direction
  loop_length = 1 (start is included now, not when we return)

  loop
    move!
    if now on S
      return loop_length/2
    else
      connections = get_connections
      came_from = opposite(next_direction)
      remove came_from from connections
      next_direction = the remaining connection
      loop_length += 1


main
  locate_start
  get_start_direction
  length_to_farthest
```

