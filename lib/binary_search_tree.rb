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

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # if node has one or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # if node has two children
      value_successor = in_order_successor(node)
      #puts(value_successor.data)
      node.set_data(value_successor.data)
      delete(value_successor.data, node.right)
    end
    node
  end

  def level_order(queue = [@root], &block)
    #if queue is empty, we are done
    if queue == []
      return nil
    end

    #get first elemet
    node = queue.shift

    #deal with front of queue
    if block_given?
      block.call(node)
    else
      puts(node.data)
    end
    #block(node)

    #add children to queue
    queue += [node.left, node.right].compact

    level_order(queue, &block)
  end

  def in_order(node = @root, &block)
    unless node.nil?
      in_order(node.left, &block)
      if block_given?
        block.call(node)
      else
        puts(node.data)
      end
      in_order(node.right, &block)
    end
  end

  def preorder(node = @root, &block)
    unless node.nil?
      if block_given?
        block.call(node)
      else
        puts(node.data)
      end
      preorder(node.left, &block)
      preorder(node.right, &block)
    end
  end

  def postorder(node = @root, &block)
    unless node.nil?
      postorder(node.left, &block)
      postorder(node.right, &block)
      if block_given?
        block.call(node)
      else
        puts(node.data)
      end
    end
  end

  def height(node)
    return -1 if node.nil?
    return [height(node.left), height(node.right)].max + 1
  end

  def depth(node, pointer = @root)
    return -1 if node.nil?
    return 0 if node.data == pointer.data
    if node.data < pointer.data
      return 1 if node.data == pointer.left.data
      return depth(node, pointer.left) + 1
    else
      return 1 if node.data == pointer.right.data
      return depth(node, pointer.right) + 1
    end
  end

  def balanced?(node = @root)
    return true if node.nil?
    return (balanced?(node.left) and balanced?(node.right) and (height(node.left) - height(node.right)).abs <= 1)
  end

  def rebalance
    unless balanced?
      node_values = []
      in_order{|node| node_values.push(node.data)}
      @root = build_tree(node_values)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  attr_accessor :root
end