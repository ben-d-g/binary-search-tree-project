require_relative("lib/node")
require_relative("lib/binary_search_tree")

#Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15){rand(1..100)})

#Confirm that the tree is balanced by calling #balanced?
puts(tree.balanced?)

#Print out all elements in level, pre, post, and in order
puts()
tree.in_order
puts()
tree.preorder
puts()
tree.postorder
puts()
tree.in_order

#Unbalance the tree by adding several numbers > 100
0.upto(5){tree.insert(rand(200..300))}

#Confirm that the tree is unbalanced by calling #balanced?
puts(tree.balanced?)

#Balance the tree by calling #rebalance
tree.rebalance

#Confirm that the tree is balanced by calling #balanced?
puts(tree.balanced?)

#Print out all elements in level, pre, post, and in order
puts()
tree.in_order
puts()
tree.preorder
puts()
tree.postorder
puts()
tree.in_order