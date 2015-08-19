class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_edge(from, to)
    from.adjacents << to
  end
end

class Node
  attr_accessor :name, :adjacents

  def initialize(name)
    @adjacents = []
    @name = name
  end
end

class ExtractWords
  WORDS = %w(popcorn corn porn dron drop)
  attr_accessor :graph, :word, :visited, :word_pan

  def initialize(graph)
    @word = ''
    @visited = []
    @word_pan = []
    @graph = graph
  end

  def extract_words
    graph.nodes.each do |node|
      @word = ''
      search_valid_word(node)
      @visited = []
    end

    print @word_pan
  end

  private

  def search_valid_word(node)
    track(node)

    @word_pan << @word.dup if is_word?

    node.adjacents.each do |n|
      search_valid_word(n) if !@visited.include?(n)
    end

    reset
  end

  def is_word?
    WORDS.include?(@word.downcase)
  end

  def reset
    @word.chop!
    @visited.pop
  end

  def track(node)
    @visited << node
    @word << node.name
  end
end

graph = Graph.new

graph.nodes << (p1 = Node.new('P'))
graph.nodes << (o1 = Node.new('O'))
graph.nodes << (c1 = Node.new('C'))
graph.nodes << (p2 = Node.new('P'))
graph.nodes << (n1 = Node.new('N'))
graph.nodes << (o2 = Node.new('O'))
graph.nodes << (d1 = Node.new('D'))
graph.nodes << (o3 = Node.new('O'))
graph.nodes << (r1 = Node.new('R'))
graph.nodes << (o4 = Node.new('O'))

graph.add_edge(p1, o4)
graph.add_edge(p1, o3)
graph.add_edge(o1, r1)
graph.add_edge(o1, c1)
graph.add_edge(c1, o1)
graph.add_edge(c1, p2)
graph.add_edge(p2, c1)
graph.add_edge(p2, o4)
graph.add_edge(n1, o2)
graph.add_edge(n1, r1)
graph.add_edge(o2, r1)
graph.add_edge(o2, n1)
graph.add_edge(d1, r1)
graph.add_edge(r1, d1)
graph.add_edge(r1, o2)
graph.add_edge(r1, n1)
graph.add_edge(r1, o3)
graph.add_edge(r1, o1)
graph.add_edge(o3, p1)
graph.add_edge(o3, r1)
graph.add_edge(o4, p1)
graph.add_edge(o4, p2)



ExtractWords.new(graph).extract_words
