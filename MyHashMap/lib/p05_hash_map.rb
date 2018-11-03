require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  
  attr_accessor :count
  
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val) 
    else
      @store[bucket(key)].append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count.times { @store << Array.new { LinkedList.new } }
    @count = 0
    
    # @store.each do |list|
    #   until list.empty?
    #     list.each 
    # 
    #   end
    # end
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
