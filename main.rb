require_relative("lib/node")
require_relative("lib/binary_search_tree")

my_arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(my_arr)

my_tree.insert(22)

my_tree.pretty_print

p(my_tree.in_order_successor(my_tree.find(8)).data)

my_tree.delete(67)

my_tree.pretty_print

my_tree.level_order{|node| puts((node.data.to_i + 2).to_s)}