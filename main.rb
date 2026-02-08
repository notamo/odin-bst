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
  bst.insert(115)
  bst.insert(113)
  bst.insert(117)
  bst.insert(114)
  bst.insert(120)
  bst.insert(118)
  bst.pretty_print

  # test delete
  # puts "deleting #{input_array[0]}..."
  # bst.delete(input_array[0])
  # bst.delete(input_array[0], nil)
  # puts 'deleting 118...'
  # bst.delete(118)
  # puts 'deleting 120...'
  # bst.delete(120)
  # puts 'deleting 115...'
  # bst.delete(115)
  # bst.pretty_print

  # puts "balanced?: #{bst.balanced?}"

  # print_level_pre_in_post(bst)

  # bst.insert(121)
  # bst.insert(151)
  # bst.insert(133)
  # puts 'Binary Search Tree (BST) after inserts'
  # bst.pretty_print
  # puts "balanced?: #{bst.balanced?}"

  # bst.rebalance
  # puts 'Binary Search Tree (BST) after rebalance'
  # bst.pretty_print
  # puts "balanced?: #{bst.balanced?}"

  # print_level_pre_in_post(bst)
end

run
