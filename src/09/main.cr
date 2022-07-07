class Day09 < DayBase
  class HeightMap
    def self.from(input)
      map = Array(Array(Int32)).new
      input.lines.each do |line|
        row = line.split("").map(&.to_i)
        map << row
      end

      new(map)
    end

    property map

    def initialize(@map : Array(Array(Int32)))
    end

    def get(x, y)
      map[y][x]
    end

    def neighbours(x, y)
      directions = [
        [0, -1], # up
        [0, 1],  # down
        [-1, 0], # left
        [1, 0],  # right
      ]
      directions
        .select { |(dx, dy)| in_bounds?(x + dx, y + dy) }
        .map { |(dx, dy)| [x + dx, y + dy] }
    end

    def lowest_points
      lowest_points = Array(Array(Int32)).new

      each_point do |x, y|
        lowest = neighbours(x, y).all? { |(ox, oy)| get(ox, oy) > get(x, y) }
        if lowest
          lowest_points << [x, y]
        end
      end

      lowest_points
    end

    private def each_point(&block)
      @map.each_with_index do |row, y|
        row.each_with_index do |val, x|
          yield(x, y)
        end
      end
    end

    private def out_of_bounds?(x, y)
      return true if x < 0
      return true if x >= map.first.size
      return true if y < 0
      return true if y >= map.size
      false
    end

    private def in_bounds?(x, y)
      !out_of_bounds?(x, y)
    end

  end

  def part_one
    heightmap = HeightMap.from(input)
    lowest_points = heightmap.lowest_points
    values = lowest_points.map { |(x, y)| heightmap.get(x, y) }
    values.sum + values.size
  end

  def part_two
    heightmap = HeightMap.from(input)
    lowest_points = heightmap.lowest_points

    basins = Array(Int32).new
    visited = Set(Tuple(Int32, Int32)).new
    lowest_points.each do |(x, y)|
      queue = Array(Tuple(Int32, Int32)).new
      queue << {x, y}
      size = 0

      while !queue.empty?
        point = queue.shift
        next if visited.includes?(point)
        visited << point
        size += 1

        heightmap.neighbours(*point).each { |(ox, oy)| queue << {ox, oy} unless heightmap.get(ox, oy) == 9 }
      end
      basins << size
    end

    basins.sort.reverse.first(3).product
  end
end
