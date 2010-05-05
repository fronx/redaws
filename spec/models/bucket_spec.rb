require 'spec_helper'

describe Bucket do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Bucket.create!(@valid_attributes)
  end
end
