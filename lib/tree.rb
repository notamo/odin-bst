class Tree
  attr_accessor :root
  attr_reader :array

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

  def delete(key, node = root)
    # puts "inside delete: key=#{key}, currently visited node=#{node.data}"
    return unless node

    if key < node.data
      node.left = delete(key, node.left)
    elsif key > node.data
      node.right = delete(key, node.right)
    else
      # puts "key=#{key} found!"

      # 0 or 1 child
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      # 2 child
      # puts "min=#{min(node).data}"
      min = min(node)
      node.data = min.data
      node.right = delete(min.data, node.right)
    end

    self.root = node
  end

  def min(node) # get min element from given node's right subtree
    current = node.right
    current = current.left while current.left
    current
  end

  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def find(value, root_node = root)
    return unless root_node

    return root_node if root_node.data == value

    if value < root_node.data
      find(value, root_node.left)
    elsif value > root_node.data
      find(value, root_node.right)
    end
  end

  def height(value)
    node = find(value)
    return nil unless node

    calculate_height(node)
  end

  def calculate_height(current_node)
    return 0 unless current_node
    return 0 if leaf?(current_node)

    left_height = calculate_height(current_node.left)
    right_height = calculate_height(current_node.right)

    [left_height, right_height].max + 1
  end

  def depth(value)
    node = find(value)
    return nil unless node

    calculate_depth(root, node, 0)
  end

  def calculate_depth(current_node, node, current_level)
    return 0 unless current_node
    return current_level if current_node == node

    left_depth = calculate_depth(current_node.left, node, current_level + 1)
    right_depth = calculate_depth(current_node.right, node, current_level + 1)
    [left_depth, right_depth].max
  end

  def balanced?(node = root)
    h_left =  node.left.nil?  ? 0 : (height(node.left.data)  || 0)
    h_right = node.right.nil? ? 0 : (height(node.right.data) || 0)

    return false if (h_left - h_right).abs > 1
    return false if node.left  && !balanced?(node.left)
    return false if node.right && !balanced?(node.right)

    true
  end

  def rebalance
    return if balanced?

    arr = level_order
    self.root = build_tree(arr)
  end

  def level_order(node = root, &block)
    return unless node

    queue = [node]
    ret = []
    until queue.empty?
      current = queue.shift

      if block.nil?
        ret << current.data
      else
        block.call current
      end

      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end

    ret unless ret.empty?
  end

  def preorder(node = root, &block)
    return nil if node.nil?

    block.call node
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def inorder(node = root, &block)
    return nil if node.nil?

    inorder(node.left, &block)
    block.call node
    inorder(node.right, &block)
  end

  def postorder(node = root, &block)
    return nil if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    block.call node
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
