class Day13 < DayBase

  def extract_instructions(input)
    dots_input, folds_input = input.raw.split("\n\n")
    dots = dots_input.split("\n").map { |data| data.split(",").map(&.to_i) }
    folds = folds_input.strip.split("\n").map { |data|
      fold, value = data.split("=")
      fold = fold.chars.last
      value = value.to_i
      {fold, value}
    }

    {dots, folds}
  end

  def build_paper(dots)
    row_length = dots.map(&.last).max + 1
    col_length = dots.map(&.first).max + 1

    paper = Array(Array(Char)).new(row_length) { Array(Char).new(col_length, '.') }

    dots.each do |(x, y)|
      paper[y][x] = '#'
    end

    paper
  end

  def process_fold(paper, fold)
    direction, idx = fold

    if direction == 'y'
      paper[idx..-1].reverse.each_with_index do |row, y|
        row.each_with_index do |val, x|
          if val == '#' || paper[y][x] == '#'
            paper[y][x] = '#'
          end
        end
      end

      paper = paper[0..idx-1]
    else
      paper.each_with_index do |row, y|
        row[idx..-1].reverse.each_with_index do |val, x|
          if val == '#' || paper[y][x] == '#'
            paper[y][x] = '#'
          end
        end
      end

      paper.map! { |row| row[0..idx-1] }
    end

    paper
  end

  def part_one
    dots, folds = extract_instructions(input)

    paper = build_paper(dots)

    paper = process_fold(paper, folds[0])

    paper.flatten.count { |v| v == '#' }
  end

  def part_two
    dots, folds = extract_instructions(input)

    paper = build_paper(dots)

    folds.each do |fold|
      paper = process_fold(paper, fold)
    end

    # Print out our code map
    # paper.each { |row| pp row.join }

    "N/A - See output"
  end
end
