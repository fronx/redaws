require 'spec_helper'

describe RemodelSorter do
  before do
    @s = RemodelSorter.new(Bucket)
  end

  it "does something" do
    @s.items.should == []
  end
end
