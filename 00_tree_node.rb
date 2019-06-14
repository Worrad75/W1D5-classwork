class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def inspect
    @value.inspect
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil? 
    @parent = parent_node
    @parent.children << self unless @parent.nil?  
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      self.children.delete(child_node)
      child_node.parent = nil
    else
      raise "node is not a child of parent!"
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue.push(self)
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end
end