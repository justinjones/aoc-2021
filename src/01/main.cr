require "../util"

class Day01 < DayBase
  def part_one
    count_increasing(input.as_integers)
  end

  def part_two
    window_sums = input.as_integers.each_cons(3).map(&.sum)
    count_increasing(window_sums)
  end

  private def count_increasing(depths)
    count = 0
    depths.each_cons(2) do |chunks|
      count += 1 if chunks.last > chunks.first
    end

    count
  end
end
