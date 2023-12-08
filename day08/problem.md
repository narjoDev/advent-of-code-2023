# Day 8

## Part One

### Problem

Input contains left/right directions and information on a network (directed graph?)

```
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
```

NODE = (LEFT, RIGHT)

- Start with `AAA`.
- Loop through left right instructions until you reach `ZZZ`
- Count the number of steps you take => How many steps required to reach `ZZZ`?

### Examples

Location: `AAA` Instruction: `L`, Node: `AAA = (BBB, CCC)` => go to `BBB`

### Data Structures

Storing the directions as a string is fine, cycle through characters

Store network as a hash:

```ruby
{ 'AAA' => ['BBB', 'CCC'] }

```

### Algorithm

```
initialize you_are_here: `'AAA'`
initialize steps taken

cycle through directions
  move
  increment steps taken
  break when at `'ZZZ'`

return steps taken
```

