class Bucket < AWSModel
  attr_accessor :name

  def initialize(attributes = {})
    @name = attributes[:name]
  end

  def self.create!(attributes = {})
    new(attributes).save!
  end

  def save!
    AWS::S3::Bucket.create(name)
  end

  def self.all
    AWS::S3::Service.buckets.sort_by(&:creation_date).reverse
  end

  # bucket.objects.map(&:to_s).join(', ')
end
