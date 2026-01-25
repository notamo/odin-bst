require_relative 'lib/node'
require_relative 'lib/tree'

input_array = Array.new(15) { rand(1..100) }
input_array.uniq!
bst = Tree.new(input_array)
puts 'Binary Search Tree (BST)'
bst.pretty_print

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

# root = input_array[0]
# p bst.height(root)
