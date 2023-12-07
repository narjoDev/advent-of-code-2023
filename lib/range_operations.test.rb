require_relative 'range_operations'

test_inclusive = false
test_exclusive = false
test_intersection = false
test_difference = true

if test_inclusive
  p(force_inclusive((1..10)) == (1..10)) &&
    (force_inclusive((1...10)) == (1..9))
end

if test_exclusive
  p(force_exclusive((1..10)) == (1...11)) &&
    (force_exclusive((1...10)) == (1...10))
end

### Intersection

if test_intersection
  p "test: intersection"
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
end

### Difference

if test_difference
  p "test: difference"
  # Covers
  p(difference((1..10), (3..6)) == [(1..2), (7..10)]) &&
    (difference((1...10), (3...6)) == [(1...3), (6...10)]) &&
    # on edge
    (difference((1...10), (3...10)) == [(1...3)])  &&
    (difference((1...10), (1...5)) == [(5...10)])  &&
    # completely (same range)
    (difference((1...10), (1...10)) == []) &&
    (difference((1..10), (1..10)) == [])

  # Outside
  p(difference((1..10), (22..30))  == [(1..10)]) &&
    (difference((1...10), (10...12))  == [(1...10)]) &&
    (difference((10...12), (1...10))  == [(10...12)])

  # single overlap
  p(difference((1..10), (10..30))  == [(1..9)]) &&
    (difference((1...10), (9...12))  == [(1...9)]) &&
    (difference((11...20), (9...12)) == [(12...20)])

  # partial
  p(difference((5..10), (1..7)) == [(8..10)]) &&
    (difference((5...10), (9...12))  == [(1...9)])
end
