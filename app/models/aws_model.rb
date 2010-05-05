class AWSModel
  Credentials = YAML::load(ERB.new(File.read(Rails.root.to_s + '/config/s3.yml')).result).symbolize_keys

  def self.connect
    AWS::S3::Base.establish_connection!(Credentials)
  end
end
