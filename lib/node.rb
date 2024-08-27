class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def num_of_children
    return 0 if (@left.nil? and @right.nil?)
    return 1 if (@left.nil? or @right.nil?)
    return 2
  end

  def nil?
    return @data.nil?
  end
  
  def <=>(other)
    data <=> other.data
  end

  def set_data(value)
    @data = value
  end

  def delete
    @data = nil
    @left = nil
    @right = nil
  end
end