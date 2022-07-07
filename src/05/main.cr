class Day05 < DayBase
  def part_one
    calculate(input)
  end

  def part_two
    calculate(input, true)
  end

  private def calculate(input, include_diagonals = false)
    hash = Hash(String, Int32).new(0)

    input.lines.each do |line|
      left, right = line.split(" -> ")
      x1, y1 = left.split(",").map(&.to_i)
      x2, y2 = right.split(",").map(&.to_i)

      if x1 == x2
        [y1, y2].min.upto([y1, y2].max) { |y| hash["#{x1},#{y}"] += 1 }
      elsif y1 == y2
        [x1, x2].min.upto([x1, x2].max) { |x| hash["#{x},#{y1}"] += 1 }
      elsif include_diagonals
        dir = [1, 1]
        if x2 < x1
          dir[0] = -1
        end
        if y2 < y1
          dir[1] = -1
        end

        while x1 != x2 + dir[0] && y1 != y2 + dir[1]
          hash["#{x1},#{y1}"] += 1
          x1 += dir[0]
          y1 += dir[1]
        end
      end
    end

    hash.values.count { |v| v >= 2 }
  end
end


