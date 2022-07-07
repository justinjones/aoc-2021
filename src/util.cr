class DayBase
  def initialize(@basepath : String, @test = false)
  end

  def part_one
    raise "Implemented in subclass"
  end

  def part_two
    raise "Implemented in subclass"
  end

  private def input
    @input ||= AocInput.new(@basepath, @test)
  end
end

class AocInput
  def initialize(@basepath : String, @test = false)
  end

  def lines
    File.read_lines(File.join("src", @basepath, path))
  end

  def raw
    File.read(File.join("src", @basepath, path))
  end

  def as_integers
    lines.map(&.to_i)
  end

  private def path
    if @test
      "test.txt"
    else
      "input.txt"
    end
  end
end
