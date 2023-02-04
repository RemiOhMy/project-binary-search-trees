# frozen-string-literal: true

require_relative 'lib/tree'

# create new tree
tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])
tree.pretty_print

# test insert, should insert new values and ignore duplicates
tree.insert(7)
tree.insert(11)
tree.pretty_print

# test delete, should delete if value exists in tree
tree.delete(11)
tree.pretty_print

# test find, should return the node that is being searched, otherwise return nil
p tree.find(11)
p tree.find(6)

# test level_order, which can accept a block and do things with values, otherwise return an breadth-level ordered list
p tree.level_order

# test inorder, which will do an inordered tree walk through the tree
p tree.inorder

# test preorder, which will do a preordered tree walk through the tree
p tree.preorder

# test postorder, which will do a postordered tree walk through the tree
p tree.postorder

# test height, which will determine the number of edges to the longest path to a leaf node from the given node
p tree.height(tree.find(5))
p tree.height(tree.find(2))
p tree.height(tree.find(8))
p tree.height(tree.find(1))

# test depth, which will determine the number of edges from the root node to the given node
p tree.depth(tree.find(5))
p tree.depth(tree.find(2))
p tree.depth(tree.find(9))
p tree.depth(tree.find(4))

# test balanced?, which will test if the tree is balanced
p tree.pretty_print
p tree.balanced?
tree.insert(10)
tree.insert(11)
p tree.pretty_print
p tree.balanced?

# test rebalance, which will rerun initialize (and build_tree) with a sorted array from the inorder method
tree.rebalance
p tree.pretty_print
p tree.balanced?

puts "\n\n------------\n\n"

# driver script
tree = Tree.new(Array.new(15) { rand(1..100) })

puts "Tree Balanced: #{tree.balanced?.to_s.capitalize}"

puts "In-order: #{tree.inorder}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "Level-order: #{tree.level_order}"
puts "Level-order (w/ Recursion): #{tree.level_order_rec}"

tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.insert(105)

tree.pretty_print

puts "Tree Balanced (after insertions): #{tree.balanced?.to_s.capitalize}"

tree.rebalance

tree.pretty_print

puts "Tree Balanced (after rebalance): #{tree.balanced?.to_s.capitalize}"

puts "In-order: #{tree.inorder}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "Level-order: #{tree.level_order}"
puts "Level-order (w/ Recursion): #{tree.level_order_rec}"

