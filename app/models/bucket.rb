class Bucket < Remodel::Entity
  include MagicParams
  extend AWSModel

  property :name, :class => 'String'
  property :created_at, :class => 'Time'
  property :object_count, :class => 'Integer'

  has_many :items, :class => 'Item', :reverse => :bucket

  delegate :objects, :to => :_bucket

  def self.sorter
    @sorter ||= RemodelSorter.new(self)
  end

  def self.find(id)
    super("#{key_prefix}:#{id}")
  end

  def self.find_by_name(name)
    all.detect { |b| b.name == name }
  end

  def self.sync
    aws.list.sort_by(&:creation_date).reverse.map do |aws_bucket|
      b = find_by_name(aws_bucket.name) || create(:name => aws_bucket.name)
      b.update({
        :created_at => aws_bucket.creation_date,
        :object_count => (aws_bucket.objects.count rescue 0),
      })
    end
  end

  def sync_items
    _bucket.objects.each do |o|
      items.create(Item.from_s3_object(o))
    end
    self
  end

  def to_param
    "#{id}"
  end

protected
  def self.aws
    return @aws if @aws
    connect
    @aws = AWS::S3::Bucket
  end

  def _bucket
    @_bucket ||= self.class.aws.find(name)
  end

end
