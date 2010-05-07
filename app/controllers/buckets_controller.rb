class BucketsController < ApplicationController
  before_filter :connect_to_aws

  def index
    @buckets = Bucket.sorter.all
  end

  def show
    @bucket = Bucket.find(params[:id])
  end

  def new
  end

  def create
    AWS::S3::Bucket.create(params[:bucket][:name])
    Bucket.sync
    redirect_to :action => index
  rescue => e
    flash[:error] = e.message
    render :new
  end

protected

  def connect_to_aws
    Bucket.connect
  end
end
