class Day06 < DayBase
  def part_one
    calculate(input, 80)
  end

  def part_two
    calculate(input, 256)
  end

  AFTER_BABY_INDEX = 6

  private def calculate(input, days)
    timers = input.raw.strip.split(",").map(&.to_i64)
    spawns = Array.new(9, 0.to_i64)

    timers.each do |timer|
      spawns[timer] += 1
    end

    days.times do
      spawns.rotate! # handle babies
      spawns[AFTER_BABY_INDEX] += spawns.last # reset mothers
    end

    spawns.sum
  end
end
