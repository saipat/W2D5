class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    xor_val = 0
    self.each_with_index do |num, i|
      xor_val ^= (num + i)
    end
    xor_val.hash
  end
end

class String
  def hash
    chars = self.chars
    chars.map! { |ch| ch.ord }
    chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    values = self.values
    hash_val = 0
    values.each do |v|
      hash_val ^= v.hash
    end
    hash_val
  end
end
