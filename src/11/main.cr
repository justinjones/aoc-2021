class Day11 < DayBase
  def build_grid(input)
    input.lines.map do |line|
      line.chars.map(&.to_i)
    end
  end

  def tick(grid)
    # Increase energy by 1
    grid = grid.map { |row| row.map { |energy| energy += 1 } }

    # Process flashes where energy == 10
    # Increase neighbours energy by 1
    neighbours = [
      {0, -1}, # up
      {0, 1}, # down
      {-1, 0}, # left
      {1, 0}, # right
      {-1, -1}, # topleft
      {1, -1}, # topright
      {-1, 1}, # bottomleft
      {1, 1}, # bottomright
    ]

    stack = Array({Int32, Int32}).new
    grid.each_with_index do |row, y|
      row.each_with_index do |energy, x|
        stack << {x, y} if energy == 10
      end
    end

    flashes = 0

    while stack.any?
      flashes += 1
      x, y = stack.pop

      neighbours.each do |(xdiff, ydiff)|
        nx, ny = x + xdiff, y + ydiff
        next if nx < 0 || nx >= grid.first.size
        next if ny < 0 || ny >= grid.size

        grid[ny][nx] += 1

        if grid[ny][nx] == 10
          stack << {nx, ny}
        end
      end
    end

    # Reset anyone with energy >= 10 to 0
    grid = grid.map { |row| row.map { |energy| energy >= 10 ? 0 : energy } }

    return {grid, flashes}
  end

  def part_one
    grid = build_grid(input)

    total_flashes = 0
    100.times do
      grid, flashes = tick(grid)
      total_flashes += flashes
    end

    total_flashes
  end

  def part_two
    grid = build_grid(input)

    i = 0
    loop do
      i += 1
      grid, flashes = tick(grid)
      if grid.flatten.all? { |energy| energy == 0 }
        break
      end
    end

    i
  end
end
