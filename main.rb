require_relative 'lib/node'
require_relative 'lib/tree'

input_array = Array.new(15) { rand(1..100) }
bst = Tree.new(input_array)
bst.pretty_print

print 'BST: '
p bst.level_order

pre_arr = []
bst.preorder do |node|
  pre_arr << node.data
end
print 'DSF preorder: '
p pre_arr

in_arr = []
bst.inorder do |node|
  in_arr << node.data
end
print 'DSF inorder: '
p in_arr

post_arr = []
bst.postorder do |node|
  post_arr << node.data
end
print 'DSF postorder: '
p post_arr
