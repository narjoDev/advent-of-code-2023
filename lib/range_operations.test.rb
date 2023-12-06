require_relative 'range_operations'

p(force_inclusive((1..10)) == (1..10)) &&
  (force_inclusive((1...10)) == (1..9))

p(force_exclusive((1..10)) == (1...11)) &&
  (force_exclusive((1...10)) == (1...10))

### Intersection

# Covers
p(intersection((1..10), (2..5)) == (2..5)) &&
  (intersection((1...10), (2...5)) == (2...5))

# Out of bounds
p(intersection((5..10), (1..4)).nil?) &&
  (intersection((5..10), (11..14)).nil?) &&
  (intersection((5...10), (1...5)).nil?) &&
  (intersection((5...10), (10...15)).nil?)

# Single overlap
p(intersection((1..10), (10..12)) == (10..10)) &&
  (intersection((10..12), (1..10)) == (10..10)) &&
  (intersection((1...11), (10...12)) == (10...11)) &&
  (intersection((10...12), (1...11)) == (10...11))

# Partial
p(intersection((1..10), (7..15)) == (7..10)) &&
  (intersection((21..30), (7..25)) == (21..25)) &&
  (intersection((1...10), (7...15)) == (7...10)) &&
  (intersection((21...30), (7...25)) == (21...25))
