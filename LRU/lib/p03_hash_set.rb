class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    self[num] << key
    @count += 1
    resize! if count == num_buckets
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    num = key.hash
    return false if !self[num].include?(key)
    self[num].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new( num_buckets * 2 ) { [] }
    @count = 0
    old_store.flatten.each { |el| insert(el) }

  end
end
