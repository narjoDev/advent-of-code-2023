def force_inclusive(range)
  (range.min..range.max)
end

def force_exclusive(range)
  (range.min...range.max + 1)
end

def overlap?(range1, range2, permit_adjacent: false)
  if permit_adjacent
    range1.min <= range2.max + 1 && range2.min <= range1.max + 1
  else
    range1.min <= range2.max && range2.min <= range1.max
  end
end

def intersection(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  return nil unless overlap?(range1, range2)

  intersection_min, intersection_max = [
    range1.min, range2.min, range1.max, range2.max
  ].sort[1, 2]

  intersection = (intersection_min..intersection_max)
  range1.exclude_end? ? force_exclusive(intersection) : intersection
end

def difference(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  leftovers = if !overlap?(range1, range2)
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

def merge_many(range_array)
  merged = [range_array.sort_by!(&:min).shift]
  range_array.each do |range|
    if overlap?(range, merged.last, permit_adjacent: true)
      min, max = [range.min, merged.last.min, range.max, merged.last.max].minmax
      merged[-1] = range.exclude_end? ? (min...max + 1) : (min..max)
    else
      merged << range
    end
  end
  merged
end
