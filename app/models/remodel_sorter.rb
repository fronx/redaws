require 'redis'

class RemodelSorter
  attr_reader :name

  def initialize(klass)
    @klass = klass
    @name = "sorter:#{klass.name}"
    init
  end

  def self.redis
    @redis ||= Redis.new
  end

  def redis
    self.class.redis
  end

  def make_key(*parts)
    "#{name}:#{parts.join(':')}"
  end

  def self.delete_all
    redis.keys('sorter:*').map { |key| redis.del(key) }
  end

  def add(o)
    redis.sadd(name, o.key)
    redis.set(make_key(o.key), o.created_at.to_i)
    self
  end

  def init
    sorted_objects.each do |o|
      add(o)
    end
    self
  end

  def sorted_objects
    @klass.all.sort_by { |b| b.created_at.to_i }.reverse
  end

  def all
    redis.sort(name,
      :by    => make_key('*'),
      :get   => "*",
      :order => 'DESC').map { |o| @klass.restore(o) }
  end
end
