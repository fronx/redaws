class RemodelSorter
  attr_reader :name

  def initialize(klass)
    @klass = klass
    @name = "sorter:#{klass.name}"
    add(klass.all.map(&:key))
  end

  def redis
    @redis ||= Redis.new
  end

  def make_key(*parts)
    "#{name}:#{parts.join(':')}"
  end

  def add(keys)
    keys = [keys] unless keys.respond_to?(:each)
    keys.each do |key|
      redis.sadd(name, key)
      redis.set(make_key(key), Time.now.to_i)
    end
  end

  def items
    redis.sort(name,
      :by    => make_key('*'),
      :get   => "*",
      :order => 'DESC').map { |o| @klass.restore(o) }
  end
end
