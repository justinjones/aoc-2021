class Day02 < DayBase
  def part_one
    position, _, aim = calculate
    position * aim
  end

  def part_two
    position, depth, _ = calculate
    position * depth
  end

  private def calculate
    position, depth, aim = 0, 0, 0

    input.lines.each do |line|
      parts = line.split
      action, val = parts.first, parts.last.to_i

      case action
      when "forward"
        position += val
        depth += aim * val
      when "down"
        aim += val
      when "up"
        aim -= val
      end
    end

    [position, depth, aim]
  end
end
