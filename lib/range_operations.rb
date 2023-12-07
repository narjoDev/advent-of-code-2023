def force_inclusive(range)
  (range.min..range.max)
end

def force_exclusive(range)
  (range.min...range.max + 1)
end

def intersection(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  return nil if range1.min > range2.max || range2.min > range1.max

  intersection_min, intersection_max = [
    range1.min, range2.min, range1.max, range2.max
  ].sort[1, 2]

  intersection = (intersection_min..intersection_max)
  range1.exclude_end? ? force_exclusive(intersection) : intersection
end

def difference(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  leftovers = if range1.min > range2.max || range2.min > range1.max
                # nothing subtracted
                [range1]
              elsif range2.cover?(range1)
                # completely subtracted
                []
              elsif range1.cover?(range2)
                # subtracted area fully within original
                [(range1.min...range2.min),
                 (range2.max + 1...range1.max + 1)]
              elsif range1.min < range2.min
                # partial overlap, top end subtracted
                [(range1.min...range2.min)]
              else
                # partial overlap, bottom end subtracted
                [(range2.max + 1..range1.max)]
              end

  leftovers.reject { |range| range.size.zero? }
           .map { |range| range1.exclude_end? ? force_exclusive(range) : force_inclusive(range) }
           .sort_by(&:min)
end
