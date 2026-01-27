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
    # TODO: handle case when you want to delete root node

    target_node = nil
    target_node_parent = nil

    level_order(node) do |current|
      children = [current.left, current.right].compact

      targets = children.filter { |child| child.data == key }
      unless targets.empty?
        target_node = targets.pop
        target_node_parent = current
        break
      end
    end

    # puts "target_node=#{target_node.data}"
    # puts "target_node_parent=#{target_node_parent.data}"

    case count_children(target_node)
    when 0
      delete_leaf(target_node, target_node_parent)
    when 1
      delete_with_one_child(target_node, target_node_parent)
    when 2
      delete_with_two_children(target_node, target_node_parent)
    end
  end

  def count_children(node)
    case [node.left.nil?, node.right.nil?].count(true)
    when 0
      2
    when 1
      1
    when 2
      0
    end
  end

  def delete_leaf(target, parent)
    puts "inside delete_leaf: target=#{target.data} parent=#{parent.data}"

    if parent.left == target
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def delete_with_one_child(target, parent)
    puts "inside delete_with_one_child: target=#{target.data} parent=#{parent.data}"

    if parent.left == target
      parent.left = target.left || target.right
    else
      parent.right = target.left || target.right
    end
  end

  def delete_with_two_children(target, parent)
    print "inside delete_with_two_children: target=#{target.data} parent=#{parent.data}"

    min = target.right
    min = min.left until min.left.nil?
    puts " min=#{min.data}"

    target.data = min.data
    delete(min.data, target)
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
