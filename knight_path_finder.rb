require_relative "00_tree_node.rb"
require "byebug"
class KnightPathFinder
  attr_accessor :start, :considered_pos, :root_node

  def self.valid_moves(pos)
    directions = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [2, -1], [-2, 1], [2, 1]]
    possible_pos = []
    directions.each do |direction|
      possible_move = [pos[0] + direction[0], pos[1] + direction[1]] 
      if KnightPathFinder.valid_pos?(possible_move)
        possible_pos << possible_move
      end
    end
    possible_pos
  end

  def self.valid_pos?(pos)
    return false if pos[0] < 0 || pos[0] > 7
    return false if pos[1] < 0 || pos[1] > 7
    true
  end

  def initialize(start)
    @start = start
    @considered_pos = [start]
    @root_node = PolyTreeNode.new(start)
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).select { |move| !@considered_pos.include?(move) }
    @considered_pos += new_moves
    new_moves
  end

  def build_move_tree
    queue = []
    queue.push(root_node)
    until queue.empty?
      first = queue.shift
      moves = self.new_move_positions(first.value)
      moves.each do |move|
        node = PolyTreeNode.new(move) 
        node.parent = first 
      end
      queue += first.children
    end
  end

  def find_path(end_pos)
    @root_node.bfs(end_pos)
  end

end

timmy = KnightPathFinder.new([0,0])
timmy.build_move_tree
p timmy.find_path([2,1])
