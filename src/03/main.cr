class Day03 < DayBase
  def part_one
    gamma, epsilon = most_common(input.lines), least_common(input.lines)
    gamma.to_i(2) * epsilon.to_i(2)
  end

  def part_two
    o2, co2 = most_common(input.lines, true), least_common(input.lines, true)
    o2.to_i(2) * co2.to_i(2)
  end

  def most_common_char(chars : Array(Char))
    zeroes, ones = chars.partition { |c| c == '0' }
    if ones.size >= zeroes.size
      '1'
    else
      '0'
    end
  end

  def least_common_char(chars : Array(Char))
    zeroes, ones = chars.partition { |c| c == '0' }
    if zeroes.size <= ones.size
      '0'
    else
      '1'
    end
  end

  private def most_common(haystack : Array(String), filter = false, prefix = "")
    return haystack.first if haystack.size == 1
    return prefix if prefix.size == haystack.first.size

    col = haystack.map(&.chars).transpose[prefix.size]
    prefix = "#{prefix}#{most_common_char(col)}"

    haystack = filter_haystack(haystack, prefix) if filter

    most_common(haystack, filter, prefix)
  end

  private def least_common(haystack : Array(String), filter = false, prefix = "")
    return haystack.first if haystack.size == 1
    return prefix if prefix.size == haystack.first.size

    col = haystack.map(&.chars).transpose[prefix.size]
    prefix = "#{prefix}#{least_common_char(col)}"

    haystack = filter_haystack(haystack, prefix) if filter

    least_common(haystack, filter, prefix)
  end

  private def filter_haystack(haystack : Array(String), prefix : String)
    haystack.select { |line| line.starts_with?(prefix) }
  end
end
