require "./util"
require "./01/main"
require "./02/main"
require "./03/main"
require "./04/main"
require "./05/main"
require "./06/main"
require "./07/main"
require "./08/main"
require "./09/main"
require "./10/main"
require "./11/main"
require "./12/main"
require "./13/main"
require "./14/main"
require "./15/main"

class Puzzle
  ALL = [
    new("01", Day01, "Sonar Sweep"),
    new("02", Day02, "Dive!"),
    new("03", Day03, "Binary Diagnostic"),
    new("04", Day04, "Giant Squid"),
    new("05", Day05, "Hydrothermal Venture"),
    new("06", Day06, "Lanternfish"),
    new("07", Day07, "The Treachery of Whales"),
    new("08", Day08, "Seven Segment Search"),
    new("09", Day09, "Smoke Basin"),
    new("10", Day10, "Syntax Scoring"),
    new("11", Day11, "Dumbo Octopus"),
    new("12", Day12, "Passage Pathing"),
    new("13", Day13, "Transparent Origami"),
    new("14", Day14, "Extended Polymerization"),
    new("15", Day15, "Chiton"),
  ]

  getter path : String, klass : DayBase.class, name : String

  def initialize(@path : String, @klass : DayBase.class, @name : String)
  end

  def part_one
    klass.new(path).part_one
  end

  def part_two
    klass.new(path).part_two
  end

  def run
    [part_one, part_two]
  end
end

class Runner
  def self.run
    out = [["Day", "Name", "Part One", "Part Two"]]
    Puzzle::ALL.each do |puzzle|
      out << [puzzle.path, puzzle.name, puzzle.part_one.to_s, puzzle.part_two.to_s]
    end

    out
  end
end

pp Runner.run
