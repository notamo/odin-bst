require_relative 'lib/node'
require_relative 'lib/tree'

input_array = Array.new(15) { rand(1..100) }
bst = Tree.new(input_array)
bst.pretty_print

p bst.level_order

# counter = 0
# bst.level_order do |node|
#   puts "#{counter}. #{node.data}"
#   counter += 1
# end

# bst.insert(10)
# bst.pretty_print
