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
  input_array = Array.new(15) { rand(1..100) }
  input_array.uniq!
  puts "Input array: #{input_array}"

  bst = Tree.new(input_array)
  puts 'Binary Search Tree (BST)'
  bst.pretty_print

  puts "balanced?: #{bst.balanced?}"

  print_level_pre_in_post(bst)

  bst.insert(121)
  bst.insert(151)
  bst.insert(133)
  puts 'Binary Search Tree (BST) after inserts'
  bst.pretty_print
  puts "balanced?: #{bst.balanced?}"

  bst.rebalance
  puts 'Binary Search Tree (BST) after rebalance'
  bst.pretty_print
  puts "balanced?: #{bst.balanced?}"

  print_level_pre_in_post(bst)

  # node = input_array[0]
  # p bst.find(node).data
end

run
