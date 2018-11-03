class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev_node = self.prev
    next_node = self.next
    
    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList
  
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    prev_node = last
    new_node = Node.new(key, val)
    
    new_node.next = @tail
    @tail.prev = new_node
    new_node.prev = prev_node
    prev_node.next = new_node      
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each { |node| node.remove if node.key == key }
  end

  def each
    current_node = @head.next
    until current_node.next.nil?
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
