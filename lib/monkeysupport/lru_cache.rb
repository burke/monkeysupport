require 'pp'

class LRUCache

  def initialize(size=200, cleanup_threshold=size*2)
    @size = size
    @cleanup_threshold = cleanup_threshold

    @cache = {}

    @access = [0]*size

    @counter = 0
  end

  def []=(key, value)
    @cache[key] = [Time.now, value]
    cleanup if @cache.size > @cleanup_threshold
  end

  def [](key)
    # @cache[key][0] = @count
    @cache[key]
  end

  def cleanup
    num_delete = @cache.size - @size
    @cache.sort_by{|k,v|v[0]}[0...num_delete].each do |arr|
      @cache.delete(arr[0])
    end
  end

  def size
    @cache.size
  end
  
end

if __FILE__ == $0
  c = LRUCache.new(2)
  c[1] = :a
  puts c.size
  c[2] = :b
  puts c.size
  c[3] = :c
  puts c.size
  c[4] = :d
  puts c.size
  c[5] = :e
  puts c.size
  c[6] = :f
  puts c.size
  
end
