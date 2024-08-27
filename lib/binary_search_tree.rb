require_relative("node")

class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    #if array is empty, return nil
    return nil if array == []

    #find middle
    mid = array.size / 2
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)...array.size])

    return root
  end

  def insert(value, node = @root)
    return nil if node.data == value

    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
        return nil
      else
        insert(value, node.left)
      end      
    else
      if node.right.nil?
        node.right = Node.new(value)
        return nil
      else
        insert(value, node.right)
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  attr_accessor :root
end