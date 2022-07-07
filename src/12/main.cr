class Day12 < DayBase
  class Node
    property nodes
    getter name

    def initialize(@name : String)
      @nodes = Set(Node).new
    end

    def add(node)
      nodes.add node
    end

    def small?
      @name.downcase == @name
    end

    def start?
      @name == "start"
    end

    def end?
      @name == "end"
    end
  end

  def build_graph(input)
    graph = Hash(String, Node).new

    input.lines.each do |line|
      src, dest = line.split("-")

      src_node = graph[src]? || Node.new(src)
      dest_node = graph[dest]? || Node.new(dest)

      src_node.add(dest_node) unless dest_node.start?
      dest_node.add(src_node) unless dest_node.end?
      graph[src] = src_node
      graph[dest] = dest_node
    end

    graph
  end

  def part_one
    graph = build_graph(input)

    traverse(graph["start"]).size
  end

  def part_two
    graph = build_graph(input)
    smalls = graph.values.select { |node| node.small? && !node.start? && !node.end? }

    smalls.map { |node| traverse(graph["start"], node) }.flatten.uniq.size
  end

  def traverse(node, visit_twice : Node? = nil, path = Array(Node).new, visited = Array(Node).new, paths = Array(String).new)
    if node.end?
      path << node
      paths << path.map(&.name).join(",")
      return paths
    end

    path << node
    visited << node

    node.nodes.each do |n|
      should_visit = !visited.includes?(n) || !n.small?
      if n == visit_twice && visited.count { |v| v == n } < 2
        should_visit = true
      end

      if should_visit
        paths = traverse(n, visit_twice, path.dup, visited.dup, paths)
      end
    end

    paths
  end
end
