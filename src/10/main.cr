class Day10 < DayBase
  MAPPING = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<',
  }

  def classify(line)
    stack = Array(Char).new

    line.chars.each do |char|
      if open = MAPPING[char]?
        if stack.last == open
          # Valid closing
          stack.pop
        else
          # Invalid closing
          return {true, [char]}
        end
      elsif MAPPING.values.includes?(char)
        stack << char
      end
    end

    return {false, stack}
  end

  def part_one
    score_mapping = {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25137,
    }

    total = 0

    input.lines.each do |line|
      is_corrupted, chars = classify(line)
      if is_corrupted
        score = score_mapping[chars.first]?
        total += score if score
      end
    end

    total
  end

  def part_two
    score_mapping = {
      '(' => 1,
      '[' => 2,
      '{' => 3,
      '<' => 4
    }

    scores = Array(Int128).new

    input.lines.each do |line|
      is_corrupted, chars = classify(line)
      if !is_corrupted
        scores << chars.reverse.reduce(0.to_i128) do |memo, char|
          memo = memo * 5
          memo += score_mapping[char]
          memo
        end
      end
    end

    scores.sort[(scores.size / 2).to_i]
  end
end
