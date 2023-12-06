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
