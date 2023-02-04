# frozen-string-literal: true

# Class Node will contain data stored into stored_data, and variables for its left and right children
class Node
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(value)
    @data = value
    @left = @right = nil
  end
end
