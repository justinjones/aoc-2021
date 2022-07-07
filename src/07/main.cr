class Day07 < DayBase
  def part_one
    calculate_least_fuel
  end

  def part_two
    calculate_least_fuel(true)
  end

  private def calculate_least_fuel(incrementing_cost = false)
    positions = input.raw.strip.split(",").map(&.to_i)

    fuel_used = Array.new(positions.max, 0)

    0.upto(fuel_used.size - 1) do |idx|
      diffs = positions.map { |p| (p - idx).abs }
      diffs = diffs.map { |d| ((d * (d + 1) / 2)).to_i } if incrementing_cost

      fuel_used[idx] = diffs.sum
    end

    fuel_used.min
  end
end
