module AWSModel
  Credentials = YAML::load(ERB.new(File.read(Rails.root.to_s + '/config/s3.yml')).result).symbolize_keys

  def connect
    AWS::S3::Base.establish_connection!(Credentials)
    self
  end
end
