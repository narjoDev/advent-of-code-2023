require_relative 'solution'

print('locate_start ')
(((locate_start(EXAMPLE_ONE) == { x: 1, y: 1 }) &&
  (locate_start(EXAMPLE_TWO) == { x: 0, y: 2 }) &&
  p('OK')) || p('FAILED'))

print('get_start_direction ')
(((['east', 'south']
    .include? get_start_direction(EXAMPLE_ONE, { x: 1, y: 1 })) &&
  (['east', 'south']
    .include? get_start_direction(EXAMPLE_TWO, { x: 0, y: 2 })) &&
  p('OK')) || p('FAILED'))

print('move! ')
test_coordinates = { x: 5, y: 10 }
(((move!(test_coordinates, 'north') == { x: 5, y: 9 }) &&
  (move!(test_coordinates, 'north') == { x: 5, y: 8 }) &&
  (move!(test_coordinates, 'west')  == { x: 4, y: 8 }) &&
  (move!(test_coordinates, 'east')  == { x: 5, y: 8 }) &&
  (move!(test_coordinates, 'south') == { x: 5, y: 9 }) &&
  p('OK')) || p('FAILED'))

print('length_to_farthest ')
tests = [
  (length_to_farthest(EXAMPLE_ONE, { x: 1, y: 1 }, 'east') == 4),
  (length_to_farthest(EXAMPLE_ONE, { x: 1, y: 1 }, 'south') == 4),
  (length_to_farthest(EXAMPLE_TWO, { x: 0, y: 2 }, 'south') == 8),
  (length_to_farthest(EXAMPLE_TWO, { x: 0, y: 2 }, 'east') == 8)
]
p(tests.all? ? 'OK' : 'FAILED')

p(part_one(EXAMPLE_ONE)  == 4)
p(part_one(EXAMPLE_TWO)  == 8)
p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
