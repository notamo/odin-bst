require_relative 'lib/node'
require_relative 'lib/tree'

input_array = Array.new(15) { rand(1..100) }
bst = Tree.new(input_array)
bst.pretty_print

found = bst.find(input_array[0])
if found.data == input_array[0]
  puts 'Correct!'
  puts "found.data: #{found.data}"
  puts "input_array[0]: #{input_array[0]}"
end

p bst.find(200)
# bst.insert(10)
# bst.pretty_print
