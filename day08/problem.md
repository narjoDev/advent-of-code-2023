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
  return steps taken when at `'ZZZ'`

```

## Part Two

### Problem

- Ghosts start at every node that end in `A`.
- They can navigate multiple locations at once.
- Simultaneously take a step with every current node
- Repeat until all nodes end with `Z`

### Examples

- `11A` ends in `A`.
- `11Z` ends in `Z`.

### Data Structures

- Instead of storing a single current node, store an array of current nodes

### Algorithm

- Filter network keys to create starting nodes
- In each cycle, take a step with every node
- Return if all nodes end in `Z`

**Alternate approach**

- For each starting node, calculate cycle length
- Take least common multiple of cycle lengths

?? Does this assume first Z is the end Z for that? and that it then goes straight to an A?

- We need to detect where the cycle begins, might not be at their origin

```
A --> B --> C
      ^     |
      |     v
      E <-- D
```

- To detect cycles, instead of changing a node, add it to an array. When next already exists, that's the first occuring node in the cycle. Index in array is when you enter cycle. Distance to end may be important.
- Let's start by finding a cycle and see if we notice anything

**Find Cycle**

Supply starting node
Add start to history array
cycle
  calculate next
  if not in history
    add to history
  else
    return next (cycle entry), history

**OKAY**

Find cycle
Need cycle length
Need steps from beginning to first instance of end

Start each node at steps_to_end
Increment by cycle length
stop when same

**GAH**

I totally neglected that the different directions change how you have to find a cycle.

For each node, store steps between ends. When it repeats, probably cycle. Would only have more than two numbers if it crosses an end more than once in pattern.

Mai says each node only ever encounters one end (**Z). If I find the first end, then find the time till it reaches it again, I have cycle length.

**ACTUAL SOLUTION**

Assume cycle is length of time till first occurence of end.

In other words, the cycle has no tail in the beginning outside the closed loop.

Find time till first end encountered for each node.

Find least common multiple of all those numbers.

Das it.