require_relative 'lib/node'
require_relative 'lib/tree'

def print_level_pre_in_post(bst)
  print 'BFS: '
  p bst.level_order

  pre_arr = []
  bst.preorder do |node|
    pre_arr << node.data
  end
  print 'DFS preorder: '
  p pre_arr

  in_arr = []
  bst.inorder do |node|
    in_arr << node.data
  end
  print 'DFS inorder: '
  p in_arr

  post_arr = []
  bst.postorder do |node|
    post_arr << node.data
  end
  print 'DFS postorder: '
  p post_arr
end

def run
  # 1. Create a binary search tree from an array of random numbers
  input_array = Array.new(15) { rand(1..100) }
  input_array.uniq!
  puts "Input array: #{input_array}"

  bst = Tree.new(input_array)
  puts 'Binary Search Tree (BST)'
  bst.pretty_print

  # 2. Confirm that the tree is balanced
  puts "balanced?: #{bst.balanced?}"

  # 3. Print out all elements in level, pre, post, and in order
  print_level_pre_in_post(bst)

  # 4. Unbalance the tree by adding several numbers whose value is more than 100
  bst.insert(115)
  bst.insert(113)
  bst.insert(117)
  bst.insert(114)
  bst.insert(120)
  bst.insert(118)
  # puts 'BST after insertion'
  # bst.pretty_print

  # 5. Confirm that the tree is unbalanced
  puts "balanced?: #{bst.balanced?}"

  # 6. Balance the tree
  bst.rebalance
  # puts 'BST after rebalance'
  # bst.pretty_print

  # 7. Confirm that the tree is balanced
  puts "balanced?: #{bst.balanced?}"

  # 8. Print out all elements in level, pre, post, and in order
  print_level_pre_in_post(bst)
end

run
