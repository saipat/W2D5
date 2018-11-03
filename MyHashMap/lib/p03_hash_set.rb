class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num.hash)
      self[num] << num.hash
      @count += 1
    end
    resize! if @count == num_buckets
  end

  def remove(num)
    if self[num].include?(num.hash)
      self[num].delete(num.hash)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num.hash)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @count.times { @store << Array.new }
    @count = 0
    nums = []
    @store.each do |bucket|
      until bucket.empty?
        nums << bucket.pop
      end
    end
    nums.each { |num| insert(num) }
  end
end


# class ResizingIntSet
#   attr_reader :count
# 
#   def initialize(num_buckets = 20)
#     @store = Array.new(num_buckets) { Array.new }
#     @count = 0
#   end
# 
#   def insert(num)
#     unless self[num].include?(num)
#       self[num] << num
#       @count += 1
#     end
#     resize! if @count == num_buckets
#   end
# 
#   def remove(num)
#     if self[num].include?(num)
#       self[num].delete(num)
#       @count -= 1
#     end
#   end
# 
#   def include?(num)
#     self[num].include?(num)
#   end
# 
#   private
# 
#   def [](num)
#     @store[num % num_buckets]
#   end
# 
#   def num_buckets
#     @store.length
#   end
# 
#   def resize!
#     @count.times { @store << Array.new }
#     @count = 0
#     nums = []
#     @store.each do |bucket|
#       until bucket.empty?
#         nums << bucket.pop
#       end
#     end
#     nums.each { |num| insert(num) }
#   end
# end
