# Day 5

## Part One

### Problem

Our input is an 'almanac' containing:
  - a list of seeds, identified by numbers

  - 'maps' from category to category (seed-to-soil, soil-to-fertilizer...)
    ...that map numbered identifiers from one category to those of another
    (numbers in different categories are independent, i.e. the same number is not necessarily connected)
    the lines of a map describe ranges of numbers that correspond
    each line of a map contains three numbers
      destination range start, source range start, range length
    unmapped source numbers correspond to the same number from the destination

the maps form a chain from category to category, finishing with 'location'
each initial seed number can be mapped through the categories to a location number

Part One Task: return the lowest location number corresponding to any of the initial seed numbers

### Examples / Test Cases

#### Input Formatting

```
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15
```

`seeds:` is on a single line, notice the plural (`seeds` != `seed`)
the category names are consistently formatted `source-to-destination map:`
  the lines of the map are in the opposite order (destination source range)
single digit numbers don't have extra padding
maps are separated by a blank line
all the categories are: `seed soil fertilizer water light temperature humidity location`

**Test** split input into the categories

#### Parsing a Map

```
seed-to-soil map:
50 98 2
52 50 48
```

`50 98 2` describes the range:
(seed => soil)
   98 => 50
   99 => 51

`52 50 48` describes:
50 => 52
51 => 53
...
97 => 99

**Test** edges of those ranges
**Test** omitted numbers map to the same number (if not key return self or something)

#### End-to-End

```
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
```

**Test** above seeds map to location numbers `82, 43, 86, 35`

### Data Structures

array of seeds
array of categories

represent ranges as a source range and an offset amount:
  `50 98 2` => { (98..99) => -48 }

nested hash contains all maps, keys are source
  {
    'seed' => { destination: 'soil', mapping: => { (98..99) => -48,  } },
    'soil' => { destination: 'fertilizer', mapping: => { ... } },
    'fertilizer' => { ... },
    ...
  }

Technically, since they're in order, an array of mappings without labels would work...

### Algorithm

#### Parsing

seeds, maps = parse_input

  DON'T start by splitting the lines of the input
  Split input by double new lines `\n\n`

  Shift first element => seeds array (still in string form with new lines)
  seeds = parse_first_line
    scan for digits and convert to integers

  Subsequent elements are each an entire map in string form
  maps = map lines of rest with parse_map(line)
    split by single new line
    first line match letters before and after `-to-` for source and destination
    number_mapping: initialize empty hash
    subsequent each represent a range
      split by spaces and convert to integers
        0: to_num, 1: from_num, 2: range_length
        offset = to_num - from_num
        range = (from_num...from_num+length)
        set mapping[range] => offset
    each map returns as an array with [source, {destination, number_mapping}]
    convert to hash (was [[k, v], [k, v]])

#### Processing

fetch_mapping(from, number, main_map)
  `from` is main hash key
  value is a hash, `mapping` key returns hash
  iterate through hash (keys = ranges)
    if number in range, increment number by offset (value) & return
  if no key matched, offset is 0, return number

trace_route(seed_number, main_map)
  traveling_number = seed_number
  iterate through map keys (source categories)
    pass category and traveling_number to fetch_mapping
  return traveling_number

part_one_main(input)
  seeds, maps = parse_input
  seed_locations = map each seed using trace_route
  seed_locations.min

## Part Two

### Problem

The seed number input is actually ranges
  the numbers are in pairs [start, length]

The end goal is the same: the lowest location number corresponding to any initial seed number

### Examples

`seeds: 79 14 55 13` => `[(55...68), (79...93)]`

When moving from one category to the next, the ranges may only partially overlap. => we need a way to pass a range into a map and get multiple ranges out

(1...10) into { (5...8) => 7 } => [ (1...5), (8...10), (12...15) ]
  range + mapping = array of ranges in next category
  this involves finding the intersection,
  subtracting the intersection from the input and modifying it
  persisting what didn't intersect from the input
    and checking those against the rest of the ranges in the mapping

It might be helpful to merge ranges:
  [ (1...5), (5...10) ] => [ (1...10) ]

### Data Structures

They are way more inputs, so to avoid taking forever we need to pass them through as ranges.

We could reuse the same data structure for the maps, but we can simplify it
  we really just need the order, not the source or destination names
  an array of mapping hashes will do just fine
  `[ { (...) => offset, (...) => offset }, { (...) => offset, (...) => offset } ]`

### Algorithm  

parse input a little differently this time
  draw owl

carry the input ranges through the mappings
probably more efficient to do a full category transition at once
  allows merging ranges

before transition: array of ranges
after transition: array of ranges, merged and sorted

map each range to its destination (each range produces an array of ranges)
flatten nested arrays of ranges
merge ranges (sorting first might help?)
sort ranges


if I successfully transform part of a range:
  I want to remove that part from the queue
  but add back the leftovers, which could be multiple ranges

range_to_destination_ranges(range, mapping)
  conversion_queue = [ range ]
  converted_ranges = []

  for each source range in mapping:
    next_queue = []
    for each range in conversion_queue:
      find intersection
      if found
        modify with offset and push to converted_ranges
        cut out intersection and push difference to next_queue
      if none, push range to next_queue
    END conversion_queue loop
    conversion_queue = next_queue
  END mapping loop

  ranges left in queue stay the same number, put them all in converted_ranges
  converted_ranges += conversion_queue
  merge if possible?
      

#### Range Operations

If we switch over to assuming inclusive ranges it'll make these simpler

Could have a guard clause to freak out if the ranges aren't the same type
  nil for different type, false for no match?
  or `raise 'Ranges aren't same type!'`

**Force Range Type**

force_inclusive(range)
  if excludes end, end -= 1

force_exclusive(range)
  if doesn't exclude end, end +=1

**Intersection**

If they overlap, the intersection will be the middle two numbers
  start, start, end, end => sort => middle 2

intersection(range1, range2)
  raise error if ranges aren't same type
  included_end1 = actual end
  included_end2 = actual end
  return nil if begin1 > included_end2 OR begin2 > included_end1
  start, start, end, end => sort => middle 2
  return range (add 1 to end if exclusive)

Test this works for edge ((4..6), (6..8)) => (6..6)

**Difference**

returns the scraps, not the cutter
difference(range1, range2) (dough, cutter)
  raise error if ranges aren't same type
  exclusive = ...
  included_end1 = actual end
  included_end2 = actual end
  
  assign leftovers to return of massive if clause
    if begin1 > included_end2 OR begin2 > included_end1
      [ range1 ] 
  <!-- after now we know there's some overlap -->
    if range2 covers range1
      []
    if range1 covers range2
      [(begin1...begin2), (included_end2 + 1...included_end1 + 1)]
  
    2 cases left: partial overlaps either end
    check which by comparing beginnings
    if begin1 < begin2
      [ (begin1...begin2) ]
    else
      [ (included_end2 + 1..included_end1) ]

  remove empty
  force inclusivity type
  sort by begin

**Merge**

merge(range1, range2)
  raise error if not same inclusivity type
  exclusive?
  convert both to exclusive
  return nil if no overlap
  [min, min, max, max] => sort => first till last (minmax)
  convert back if exclusive

merge_many(array_of_ranges)
  ...?