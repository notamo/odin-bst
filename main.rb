require_relative 'lib/node'
require_relative 'lib/tree'

n1 = Node.new(1)
n2 = Node.new(2)

puts "n1 < n2: #{n1 < n2}"

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
bst.pretty_print

bst.insert(10)
bst.pretty_print
