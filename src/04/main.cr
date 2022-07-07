class Day04 < DayBase
  def part_one
    bingo = Bingo.from_input(input.raw)
    bingo.first_winner!
  end

  def part_two
    bingo = Bingo.from_input(input.raw)
    bingo.last_winner!
  end
end

class Board
  def initialize(@rows : Array(Set(Int32)), @cols : Array(Set(Int32)))
  end

  def wins?(picks)
    @rows.any? { |row| (row - picks).empty? } || @cols.any? { |col| (col - picks).empty? }
  end

  def calculate_result(picks)
    unmarked_sum = @rows.map { |row| (row - picks) }.map(&.sum).sum
    unmarked_sum * picks.last
  end
end

class Bingo
  def self.from_input(input : String)
    lines = input.split(/\n+/)
    picks = lines.shift.split(",").map(&.to_i)

    board_idx = 0
    boards = Array(Board).new
    rows = Array(Array(Int32)).new
    lines.each do |row|
      next if row.blank?

      nums = row.strip.split(/\s+/).map(&.to_i)
      rows << nums

      board_idx += 1

      if board_idx == 5
        board_idx = 0
        boards << Board.new(rows.map(&.to_set), rows.transpose.map(&.to_set))
        rows = Array(Array(Int32)).new
      end
    end

    new(boards, picks)
  end

  def initialize(@boards : Array(Board), @picks : Array(Int32))
  end

  def first_winner!(n = 5)
    test = @picks.first(n)
    @boards.each do |board|
      if board.wins?(test)
        return board.calculate_result(test)
      end
    end

    first_winner!(n + 1)
  end

  def last_winner!(n = 5)
    test = @picks.first(n)
    losers = @boards.select { |board| !board.wins?(test) }

    # Once there is one loser, find the point at which it wins and calc result
    if losers.size == 1 && losers.first.wins?(@picks.first(n + 1))
      return losers.first.calculate_result(@picks.first(n + 1))
    end

    last_winner!(n + 1)
  end
end
