# Day 15

## Part One

**HASH algorithm**

- Start with value `0`
- For each character starting from beginning:
  - Increase value by ASCII code of character
  - Multiply value by 17
  - Set value to value % 256

- Input is a comma-separated list of steps
- Map each step to its HASH algorithm output
- Sum

## Part Two

### Problem

- HASH algorithm is correct
- There are 256 boxes numbered 0-255
- Boxes can hold lenses, but start empty
- Input is initialization instructions, in steps
- Each step changes what lenses are in a box
- Follow the steps to set the right lenses
- Add up the focusing power of all lenses

#### Steps

- e.g. `rn=1`
- lens label (letters), operator (-/=), focal length (number 1-9) (only if `=`)
- Box number is result of hash algorithm on label
- operator `-` remove the lens from the appropriate box
  - maintain order of other lenses, move them 'forward' in box
- operator `=` followed by focal length to go in the relevant box
  - if that label already in box, change the focal length to this one
  - if not already in box, add this lens behind lenses in box

#### Focusing Power

- Multiply together:
  - 1 + box number
  - slot number of lens within box (1 in front, then 2, 3...) (index + 1)
  - focal length

### Examples

```
'rn=1'
label: 'rn', operator: '=', focal_length: 1
box: 0
Result: Box 0: [['rn', 1]]
```

### Data Structures

- Hash for boxes, each has list of lenses, lens is 2-element array

```ruby
boxes = {
  0 => [['rn', 1], ['cm', 2]],
  1 => [['qp', 3]]
}
```

### Algorithm

- Initialize empty box hash
- Modify box hash by iterating across steps and performing
- Score each box and sum

```
do_step(step, boxes)
  label, operator, focal = regex...
  box_number = hash_value(label)
  lenses = fetch from boxes or empty array
  operator `-`
    lenses = reject label from lenses
  operator `=`
    index of lens with the label
    if index, overwrite focal in lenses
    else push new lens to lenses
  change value in boxes hash to lenses
  return nil

score_box(box_number, lenses)
  lenses.each_with_index.sum {...}

part_two(input string)
  split steps
  initialize empty boxes
  steps.each do_step(step, boxes)
  boxes.sum score_box(*box)
```
