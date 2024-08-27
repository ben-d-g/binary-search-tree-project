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

  def find(value, node = @root)
    return node if node.data == value
    return nil if node.num_of_children == 0
    return find(value, node.left) if value < node.data
    return find(value, node.right) if value > node.data
  end

  def in_order_successor(node)
    return nil if node.right.nil?
    
    pointer = node.right
    until pointer.left.nil?
      pointer = pointer.left
    end
    return pointer
  end

  def delete(node)
    if node.num_of_children == 0
      node.delete
    elsif node.num_of_children == 2
      node.set_data(in_order_successor(node).data)
      in_order_successor(node).delete
    else
      if not node.left.nil?
        node.set_data(node.left.data)
        delete(node.left)
      else
        node.set_data(node.right.data)
        delete(node.right)
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