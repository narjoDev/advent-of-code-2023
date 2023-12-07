def force_inclusive(range)
  range_end = range.end
  range_end -= 1 if range.exclude_end?
  (range.begin..range_end)
end

def force_exclusive(range)
  range_end = range.end
  range_end += 1 unless range.exclude_end?
  (range.begin...range_end)
end

def intersection(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  exclusive = range1.exclude_end?
  inclusive_end1 = exclusive ? range1.end - 1 : range1.end
  inclusive_end2 = exclusive ? range2.end - 1 : range2.end

  return nil if range1.begin > inclusive_end2 || range2.begin > inclusive_end1

  intersection_begin, intersection_end = [
    range1.begin, range2.begin, inclusive_end1, inclusive_end2
  ].sort[1, 2]

  if exclusive
    (intersection_begin...intersection_end + 1)
  else
    (intersection_begin..intersection_end)
  end
end

def difference(range1, range2)
  raise "Ranges have different inclusivity types" unless
    range1.exclude_end? == range2.exclude_end?

  exclusive = range1.exclude_end?
  inclusive_end1 = exclusive ? range1.end - 1 : range1.end
  inclusive_end2 = exclusive ? range2.end - 1 : range2.end

  leftovers = if range1.begin > inclusive_end2 || range2.begin > inclusive_end1
                # nothing subtracted
                [range1]
              elsif range2.cover?(range1)
                # completely subtracted
                []
              elsif range1.cover?(range2)
                # subtracted area fully within original
                [(range1.begin...range2.begin),
                 (inclusive_end2 + 1...inclusive_end1 + 1)]
              elsif range1.begin < range2.begin
                # partial overlap, top end subtracted
                [(range1.begin...range2.begin)]
              else
                # partial overlap, bottom end subtracted
                [(inclusive_end2 + 1..inclusive_end1)]
              end

  leftovers.reject { |range| range.size.zero? }
           .map { |range| exclusive ? force_exclusive(range) : force_inclusive(range) }
           .sort_by(&:begin)
end
