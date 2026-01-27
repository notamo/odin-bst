class Tree
  attr_reader :array, :root

  def initialize(arr)
    @array = arr.sort.uniq
    @root = build_tree(array)
  end

  def build_tree(arr)
    return if arr.empty?

    mid = (arr.length - 1) / 2
    root_node = Node.new(arr[mid])

    root_node.left = build_tree(arr[0...mid])
    root_node.right = build_tree(arr[(mid + 1)..])

    root_node
  end

  def insert(key, root_node = root)
    return unless root_node

    if key < root_node.data
      root_node.left ? insert(key, root_node.left) : root_node.left = Node.new(key)
    else
      root_node.right ? insert(key, root_node.right) : root_node.right = Node.new(key)
    end
  end

  def delete(key, root_node = root)
    return unless root_node

    if key < root_node.data
      raise ArgumentError unless root_node.left

      delete(key, root_node.left)
    elsif key > root_node.data
      raise ArgumentError unless root_node.right

      delete(key, root_node.right)
    else
      # found element to delete
      # if is_leaf?(root_node)
      #   PROBLEM: to delete current node I need a reference to it's parent
      #   I should probably traverse tree in level-order and inspect currently
      #   visited node's children...
      # end
    end
  end
  # def is_leaf?(node)
  #  node.left.nil? && node.right.nil?
  # end

  def find(value, root_node = root)
    return unless root_node

    return root_node if root_node.data == value

    if value < root_node.data
      find(value, root_node.left)
    elsif value > root_node.data
      find(value, root_node.right)
    end
  end

  def height(value, root_node = root)
    node = find(value)
    return nil unless node

    pretty_print(node)
    levels = traverse_and_store_level(node, 0, {})
    levels.values.max
  end

  def traverse_and_store_level(node, current_level, levels)
    return unless node

    levels[node] = current_level
    traverse_and_store_level(node.left, current_level + 1, levels)
    traverse_and_store_level(node.right, current_level + 1, levels)

    levels
  end

  def level_order(root_node = root, &block)
    return unless root_node

    queue = [root_node]
    ret = []
    until queue.empty?
      current_node = queue.shift

      if block.nil?
        ret << current_node.data
      else
        block.call current_node
      end

      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end

    ret unless ret.empty?
  end

  def preorder(root_node = root, &block)
    return nil if root_node.nil?

    yield root_node
    preorder(root_node.left, &block)
    preorder(root_node.right, &block)
  end

  def inorder(root_node = root, &block)
    return nil if root_node.nil?

    inorder(root_node.left, &block)
    yield root_node
    inorder(root_node.right, &block)
  end

  def postorder(root_node = root, &block)
    return nil if root_node.nil?

    postorder(root_node.left, &block)
    postorder(root_node.right, &block)
    yield root_node
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
