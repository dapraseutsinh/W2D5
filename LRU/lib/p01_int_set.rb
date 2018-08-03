class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    if num > store.length
      raise "Out of bounds"
    elsif num < 0
      raise "Out of bounds"
    else
      store[num] = true
    end
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [Array.new] }
    @count = 0
  end

  def insert(num)
    return false if self[num].include?(num)
    self[num] << num
    @count += 1
    resize! if count == num_buckets
  end

  def remove(num)
    return false if !self[num].include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { [Array.new] }
    @old_store.flatten.each { |el| insert(el) }
    # @store = @old_store
  end
end
