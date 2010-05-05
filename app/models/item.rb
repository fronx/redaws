class Item < Remodel::Entity
  property :path, :class => 'String'
  property :etag, :class => 'String'
  property :content_length, :class => 'Integer'
  property :date, :class => 'Time'
  property :last_modified, :class => 'Time'

  has_one :bucket, :class => 'Bucket', :reverse => :items

  extend AWSModel

  def self.from_s3_object(o)
    {
      :path => o.path,
      :etag => o.about['etag'],
      :content_length => o.about['content-length'].to_i,
      :date => Time.parse(o.about['date']),
      :last_modified => Time.parse(o.about['last_modified']),
    }
  end
end
