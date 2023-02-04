# frozen-string-literal: true

require_relative 'node'
require 'pry-byebug'

# Class Tree to represent a binary search tree, and accepts an array to form the tree
class Tree
  attr_accessor :root_node

  def initialize(array = [])
    data = array.uniq.sort
    @root_node = build_tree(data, 0, data.length - 1)
  end

  def build_tree(array, start_pos, end_pos)
    return nil if start_pos > end_pos

    mid_pos = (start_pos + end_pos) / 2

    root = Node.new(array[mid_pos])

    root.left = build_tree(array, start_pos, mid_pos - 1)
    root.right = build_tree(array, mid_pos + 1, end_pos)

    root
  end

  def pretty_print(node = @root_node, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root_node)
    return Node.new(value) if node.nil?

    if value == node.data
      node
    elsif value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value)
    @root_node = delete_data(value)
  end

  def delete_data(value, node = @root_node)
    return node if node.nil?

    # recur through the tree if value less than or greater than current node
    if value < node.data
      node.left = delete_data(value, node.left)
    elsif value > node.data
      node.right = delete_data(value, node.right)
    # when value gets to the node with the matching value
    else
      # when the node has 0 children
      if node.left.nil? && node.right.nil?
        return node = nil

      # when the node has 1 child
      elsif node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      # when the node has two children
      node.data = min_value(node.right)

      node.right = delete_data(node.data, node.right)
    end

    node
  end

  def min_value(node = @root_node)
    min = node.data

    until node.left.nil?
      min = node.left.data
      node = node.left
    end
    min
  end

  def find(value, node = @root_node)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    end
  end

  # iterative version of level_order
  def level_order
    queue = [@root_node]
    values = []

    until queue.empty?
      current = queue.first

      # if a block is given, yield the current node to the block, then push node data into values
      yield current if block_given?
      values.push(current.data)

      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      queue.shift
    end

    values
  end

  # recursive version of level_order
  def level_order_rec(queue = [@root_node], values = [])
    return if queue.empty?

    current = queue.first
    # if a block is given, yield the current node to the block, then push node data into values
    yield current if block_given?
    values.push(current.data)

    queue.push(current.left) unless current.left.nil?
    queue.push(current.right) unless current.right.nil?
    queue.shift
    level_order_rec(queue, values)

    values
  end

  def inorder(node = @root_node, values = [])
    return if node.nil?

    inorder(node.left, values)
    block_given? ? yield(node) : values.push(node.data)
    inorder(node.right, values)

    values
  end

  def preorder(node = @root_node, values = [])
    return if node.nil? || node.data.nil?

    block_given? ? yield(node) : values.push(node.data)
    preorder(node.left, values)
    preorder(node.right, values)

    values
  end

  def postorder(node = @root_node, values = [])
    return if node.nil? || node.data.nil?

    postorder(node.left, values)
    postorder(node.right, values)
    block_given? ? yield(node) : values.push(node.data)

    values
  end

  def height(node, h = 0)
    return -1 if node.nil?
    return h if node.left.nil? && node.right.nil?

    left_subtree = height(node.left, h + 1)

    right_subtree = height(node.right, h + 1)

    left_subtree > right_subtree ? left_subtree : right_subtree
  end

  def depth(node, h = 0, root = @root_node)
    return -1 if node.nil?
    return h if node == root

    if node.data < root.data
      depth(node, h + 1, root.left)
    elsif node.data > root.data
      depth(node, h + 1, root.right)
    end
  end

  def balanced?(node = @root_node)
    return true if node.left.nil? && node.right.nil?

    left_subtree = height(node.left)

    right_subtree = height(node.right)

    diff = (left_subtree - right_subtree).abs

    if diff > 1
      false
    else
      balanced?(node.left) unless node.left.nil?
      balanced?(node.right) unless node.right.nil?
    end
  end

  def rebalance
    initialize(inorder)
  end
end
